import Display
import UIKit
import AsyncDisplayKit
import Postbox
import TelegramCore
import SwiftSignalKit
import TelegramPresentationData
import AccountContext
import SearchBarNode
import ContactListUI
import SearchUI
import SolidRoundedButtonNode

final class ContactSelectionControllerNode: ASDisplayNode {
    var displayProgress: Bool = false {
        didSet {
            if self.displayProgress != oldValue {
                self.dimNode.alpha = self.displayProgress ? 1.0 : 0.0
                self.dimNode.isUserInteractionEnabled = self.displayProgress
            }
        }
    }
    
    private let displayDeviceContacts: Bool
    private let displayCallIcons: Bool
    private let allowChannelsInSearch: Bool
    private let filters: [ContactListFilter]
    
    let contactListNode: ContactListNode
    private let dimNode: ASDisplayNode
    
    private let context: AccountContext
    private var searchDisplayController: SearchDisplayController?
    
    private var containerLayout: (ContainerViewLayout, CGFloat, CGFloat)?
    
    var navigationBar: NavigationBar?
    
    var requestDeactivateSearch: (() -> Void)?
    var requestOpenPeerFromSearch: ((ContactListPeer, ContactListAction) -> Void)?
    var requestOpenDisabledPeerFromSearch: ((EnginePeer, ChatListDisabledPeerReason) -> Void)?
    var requestMultipleAction: ((_ silent: Bool, _ scheduleTime: Int32?, _ parameters: ChatSendMessageActionSheetController.SendParameters?) -> Void)?
    var dismiss: (() -> Void)?
    var cancelSearch: (() -> Void)?
    var openPeerMore: ((ContactListPeer, ASDisplayNode?, ContextGesture?) -> Void)?
    
    let isPeerEnabled: (ContactListPeer) -> Bool
    
    var presentationData: PresentationData {
        didSet {
            self.presentationDataPromise.set(.single(self.presentationData))
        }
    }
    private var presentationDataPromise = Promise<PresentationData>()
    
    private let countPanelNode: ContactSelectionCountPanelNode
    
    private var selectionState: ContactListNodeGroupSelectionState?
    
    var searchContainerNode: ContactsSearchContainerNode?
    
    init(context: AccountContext, mode: ContactSelectionControllerMode, presentationData: PresentationData, options: Signal<[ContactListAdditionalOption], NoError>, displayDeviceContacts: Bool, displayCallIcons: Bool, multipleSelection: Bool, requirePhoneNumbers: Bool, allowChannelsInSearch: Bool, isPeerEnabled: @escaping (ContactListPeer) -> Bool) {
        self.context = context
        self.presentationData = presentationData
        self.displayDeviceContacts = displayDeviceContacts
        self.displayCallIcons = displayCallIcons
        self.allowChannelsInSearch = allowChannelsInSearch
        self.isPeerEnabled = isPeerEnabled
        
        var excludeSelf = true
        
        let displayTopPeers: ContactListPresentation.TopPeers
        if case let .starsGifting(birthdays, hasActions, showSelf, selfSubtitle) = mode {
            if showSelf {
                excludeSelf = false
            }
            if let birthdays {
                let today = Calendar(identifier: .gregorian).component(.day, from: Date())
                var sections: [(String, [EnginePeer.Id], Bool)] = []
                var todayPeers: [EnginePeer.Id] = []
                var yesterdayPeers: [EnginePeer.Id] = []
                var tomorrowPeers: [EnginePeer.Id] = []
                
                for (peerId, birthday) in birthdays {
                    if birthday.day == today {
                        todayPeers.append(peerId)
                    } else if birthday.day == today - 1 || birthday.day > today + 5 {
                        yesterdayPeers.append(peerId)
                    } else if birthday.day == today + 1 || birthday.day < today + 5 {
                        tomorrowPeers.append(peerId)
                    }
                }
                
                if !todayPeers.isEmpty {
                    sections.append((presentationData.strings.Premium_Gift_ContactSelection_BirthdayToday, todayPeers, hasActions))
                }
                if !yesterdayPeers.isEmpty {
                    sections.append((presentationData.strings.Premium_Gift_ContactSelection_BirthdayYesterday, yesterdayPeers, hasActions))
                }
                if !tomorrowPeers.isEmpty {
                    sections.append((presentationData.strings.Premium_Gift_ContactSelection_BirthdayTomorrow, tomorrowPeers, hasActions))
                }
                
                displayTopPeers = .custom(showSelf: showSelf, selfSubtitle: selfSubtitle, sections: sections)
            } else {
                displayTopPeers = .recent
            }
        } else {
            displayTopPeers = .none
        }
        
        var filters: [ContactListFilter] = []
        if excludeSelf {
            filters.append(.excludeSelf)
        }
        if requirePhoneNumbers {
            filters.append(.excludeWithoutPhoneNumbers)
        }
        if case .starsGifting = mode {
            filters.append(.excludeBots)
        }
        self.filters = filters
        
        let presentation: Signal<ContactListPresentation, NoError> = options
        |> map { options in
            return .natural(options: options, includeChatList: false, topPeers: displayTopPeers)
        }
        
        var contextActionImpl: ((EnginePeer, ASDisplayNode, ContextGesture?, CGPoint?) -> Void)?
        self.contactListNode = ContactListNode(context: context, updatedPresentationData: (presentationData, self.presentationDataPromise.get()), presentation: presentation, filters: filters, onlyWriteable: false, isGroupInvitation: false, isPeerEnabled: { peer in
            return isPeerEnabled(.peer(peer: peer._asPeer(), isGlobal: false, participantCount: nil))
        }, displayCallIcons: displayCallIcons, contextAction: multipleSelection ? { peer, node, gesture, _, _ in
            contextActionImpl?(peer, node, gesture, nil)
        } : nil, multipleSelection: multipleSelection)
        
        self.dimNode = ASDisplayNode()
        
        var shareImpl: (() -> Void)?
        self.countPanelNode = ContactSelectionCountPanelNode(theme: self.presentationData.theme, strings: self.presentationData.strings, action: {
            shareImpl?()
        })
        
        super.init()
        
        self.setViewBlock({
            return UITracingLayerView()
        })
        
        self.backgroundColor = self.presentationData.theme.chatList.backgroundColor
        
        self.addSubnode(self.contactListNode)
                
        self.dimNode.backgroundColor = self.presentationData.theme.list.plainBackgroundColor.withAlphaComponent(0.5)
        self.dimNode.alpha = 0.0
        self.dimNode.isUserInteractionEnabled = false
        self.addSubnode(self.dimNode)
        
        self.addSubnode(self.countPanelNode)
        
        self.contactListNode.selectionStateUpdated = { [weak self] selectionState in
            if let strongSelf = self {
                strongSelf.countPanelNode.count = selectionState?.selectedPeerIndices.count ?? 0
                let previousState = strongSelf.selectionState
                strongSelf.selectionState = selectionState
                if previousState?.selectedPeerIndices.isEmpty != strongSelf.selectionState?.selectedPeerIndices.isEmpty {
                    if let (layout, navigationHeight, actualNavigationHeight) = strongSelf.containerLayout {
                        strongSelf.containerLayoutUpdated(layout, navigationBarHeight: navigationHeight, actualNavigationBarHeight: actualNavigationHeight, transition: .animated(duration: 0.3, curve: .spring))
                    }
                }
            }
        }
        
        shareImpl = { [weak self] in
            self?.requestMultipleAction?(false, nil, nil)
        }
        
        contextActionImpl = { [weak self] peer, node, gesture, _ in
            if let strongSelf = self, (strongSelf.selectionState?.selectedPeerIndices.isEmpty ?? true) {
                strongSelf.contactListNode.updateSelectionState { state in
                    let peerId = ContactListPeerId.peer(peer.id)
                    let state = state ?? ContactListNodeGroupSelectionState()
                    return state.withToggledPeerId(peerId).withSelectedPeerMap([peerId: ContactListPeer.peer(peer: peer._asPeer(), isGlobal: false, participantCount: nil)])
                }
            }
        }
    }
    
    func beginSelection() {
        self.contactListNode.updateSelectionState({ _ in
            return ContactListNodeGroupSelectionState()
        })
    }
    
    func updatePresentationData(_ presentationData: PresentationData) {
        self.presentationData = presentationData
        self.backgroundColor = self.presentationData.theme.chatList.backgroundColor
        self.searchDisplayController?.updatePresentationData(presentationData)
        self.dimNode.backgroundColor = self.presentationData.theme.list.plainBackgroundColor.withAlphaComponent(0.5)
    }
    
    func containerLayoutUpdated(_ layout: ContainerViewLayout, navigationBarHeight: CGFloat, actualNavigationBarHeight: CGFloat, transition: ContainedViewLayoutTransition) {
        self.containerLayout = (layout, navigationBarHeight, actualNavigationBarHeight)
        
        transition.updateFrame(node: self.dimNode, frame: CGRect(origin: CGPoint(), size: layout.size))
        
        var insets = layout.insets(options: [.input])
        insets.top += navigationBarHeight
        
        var headerInsets = layout.insets(options: [.input])
        headerInsets.top += actualNavigationBarHeight
        
        if let searchDisplayController = self.searchDisplayController {
            searchDisplayController.containerLayoutUpdated(layout, navigationBarHeight: navigationBarHeight, transition: transition)
        }
        
        self.contactListNode.containerLayoutUpdated(ContainerViewLayout(size: layout.size, metrics: layout.metrics, deviceMetrics: layout.deviceMetrics, intrinsicInsets: insets, safeInsets: layout.safeInsets, additionalInsets: layout.additionalInsets, statusBarHeight: layout.statusBarHeight, inputHeight: layout.inputHeight, inputHeightIsInteractivellyChanging: layout.inputHeightIsInteractivellyChanging, inVoiceOver: layout.inVoiceOver), headerInsets: headerInsets, storiesInset: 0.0, transition: transition)
        
        self.contactListNode.frame = CGRect(origin: CGPoint(), size: layout.size)
        
//        let countPanelHeight = self.countPanelNode.updateLayout(width: layout.size.width, sideInset: layout.safeInsets.left, bottomInset: layout.intrinsicInsets.bottom, transition: transition)
//        if (self.selectionState?.selectedPeerIndices.isEmpty ?? true) {
//            transition.updateFrame(node: self.countPanelNode, frame: CGRect(origin: CGPoint(x: 0.0, y: layout.size.height), size: CGSize(width: layout.size.width, height: countPanelHeight)))
//        } else {
//            insets.bottom += countPanelHeight
//            transition.updateFrame(node: self.countPanelNode, frame: CGRect(origin: CGPoint(x: 0.0, y: layout.size.height - countPanelHeight), size: CGSize(width: layout.size.width, height: countPanelHeight)))
//        }
        
        if let searchDisplayController = self.searchDisplayController {
            searchDisplayController.containerLayoutUpdated(layout, navigationBarHeight: navigationBarHeight, transition: transition)
        }
        
        if let searchContainerNode = self.searchContainerNode {
            searchContainerNode.frame = CGRect(origin: CGPoint(), size: layout.size)
            searchContainerNode.containerLayoutUpdated(ContainerViewLayout(size: layout.size, metrics: LayoutMetrics(), deviceMetrics: layout.deviceMetrics, intrinsicInsets: layout.intrinsicInsets, safeInsets: layout.safeInsets, additionalInsets: layout.additionalInsets, statusBarHeight: nil, inputHeight: layout.inputHeight, inputHeightIsInteractivellyChanging: layout.inputHeightIsInteractivellyChanging, inVoiceOver: layout.inVoiceOver), navigationBarHeight: navigationBarHeight, transition: transition)
        }
    }
    
    func scrollToTop() {
        if let searchContainerNode = self.searchContainerNode {
            searchContainerNode.scrollToTop()
        } else {
            self.contactListNode.scrollToTop()
        }
    }
    
    func activateOverlaySearch() {
        guard let (containerLayout, navigationBarHeight, actualNavigationBarHeight) = self.containerLayout, let navigationBar = self.navigationBar, self.searchDisplayController == nil else {
            return
        }
        
        var categories: ContactsSearchCategories = [.cloudContacts]
        if self.displayDeviceContacts {
            categories.insert(.deviceContacts)
        } else {
            categories.insert(.global)
        }
        if self.allowChannelsInSearch {
            categories.insert(.channels)
        }
        
        let searchContainerNode = ContactsSearchContainerNode(context: self.context, updatedPresentationData: (self.presentationData, self.presentationDataPromise.get()), onlyWriteable: false, categories: categories, filters: self.filters, displayCallIcons: self.displayCallIcons, isPeerEnabled: self.isPeerEnabled, addContact: nil, openPeer: { [weak self] peer, action in
            if let strongSelf = self {
                var updated = false
                strongSelf.contactListNode.updateSelectionState { state -> ContactListNodeGroupSelectionState? in
                    if let state = state {
                        updated = true
                        var foundPeers = state.foundPeers
                        var selectedPeerMap = state.selectedPeerMap
                        selectedPeerMap[peer.id] = peer
                        var exists = false
                        for foundPeer in foundPeers {
                            if peer.id == foundPeer.id {
                                exists = true
                                break
                            }
                        }
                        if !exists {
                            foundPeers.insert(peer, at: 0)
                        }
                        return state.withToggledPeerId(peer.id).withFoundPeers(foundPeers).withSelectedPeerMap(selectedPeerMap)
                    } else {
                        return nil
                    }
                }
                if updated {
                    strongSelf.requestDeactivateSearch?()
                } else {
                    let mappedAction: ContactListAction
                    switch action {
                    case .generic:
                        mappedAction = .generic
                    case .voiceCall:
                        mappedAction = .voiceCall
                    case .videoCall:
                        mappedAction = .videoCall
                    }
                    strongSelf.requestOpenPeerFromSearch?(peer, mappedAction)
                }
            }
        }, openDisabledPeer: { [weak self] peer, reason in
            guard let self else {
                return
            }
            self.requestOpenDisabledPeerFromSearch?(peer, reason)
        }, contextAction: nil)
        searchContainerNode.cancel = { [weak self] in
            self?.cancelSearch?()
        }
        self.insertSubnode(searchContainerNode, belowSubnode: navigationBar)
        self.searchContainerNode = searchContainerNode
        
        searchContainerNode.layer.animateAlpha(from: 0.0, to: 1.0, duration: 0.3)
        
        self.containerLayoutUpdated(containerLayout, navigationBarHeight: navigationBarHeight, actualNavigationBarHeight: actualNavigationBarHeight, transition: .immediate)
    }
    
    func deactivateOverlaySearch() {
        guard let searchContainerNode = self.searchContainerNode else {
            return
        }
        searchContainerNode.layer.animateAlpha(from: 1.0, to: 0.0, duration: 0.3, removeOnCompletion: false, completion: { [weak searchContainerNode] _ in
            searchContainerNode?.removeFromSupernode()
        })
        self.searchContainerNode = nil
    }
    
    func activateSearch(placeholderNode: SearchBarPlaceholderNode) {
        guard let (containerLayout, navigationBarHeight, _) = self.containerLayout, let navigationBar = self.navigationBar, self.searchDisplayController == nil else {
            return
        }
        
        var categories: ContactsSearchCategories = [.cloudContacts]
        if self.displayDeviceContacts {
            categories.insert(.deviceContacts)
        } else {
            categories.insert(.global)
        }
        if self.allowChannelsInSearch {
            categories.insert(.channels)
        }
        
        self.searchDisplayController = SearchDisplayController(presentationData: self.presentationData, contentNode: ContactsSearchContainerNode(context: self.context, updatedPresentationData: (self.presentationData, self.presentationDataPromise.get()), onlyWriteable: false, categories: categories, filters: self.filters, displayCallIcons: self.displayCallIcons, isPeerEnabled: self.isPeerEnabled, addContact: nil, openPeer: { [weak self] peer, action in
            if let strongSelf = self {
                var updated = false
                strongSelf.contactListNode.updateSelectionState { state -> ContactListNodeGroupSelectionState? in
                    if let state = state {
                        updated = true
                        var foundPeers = state.foundPeers
                        var selectedPeerMap = state.selectedPeerMap
                        selectedPeerMap[peer.id] = peer
                        var exists = false
                        for foundPeer in foundPeers {
                            if peer.id == foundPeer.id {
                                exists = true
                                break
                            }
                        }
                        if !exists {
                            foundPeers.insert(peer, at: 0)
                        }
                        return state.withToggledPeerId(peer.id).withFoundPeers(foundPeers).withSelectedPeerMap(selectedPeerMap)
                    } else {
                        return nil
                    }
                }
                if updated {
                    strongSelf.requestDeactivateSearch?()
                } else {
                    let mappedAction: ContactListAction
                    switch action {
                    case .generic:
                        mappedAction = .generic
                    case .voiceCall:
                        mappedAction = .voiceCall
                    case .videoCall:
                        mappedAction = .videoCall
                    }
                    strongSelf.requestOpenPeerFromSearch?(peer, mappedAction)
                }
            }
        }, openDisabledPeer: { [weak self] peer, reason in
            guard let self else {
                return
            }
            self.requestOpenDisabledPeerFromSearch?(peer, reason)
        }, contextAction: nil), cancel: { [weak self] in
            if let requestDeactivateSearch = self?.requestDeactivateSearch {
                requestDeactivateSearch()
            }
        })
        
        self.searchDisplayController?.containerLayoutUpdated(containerLayout, navigationBarHeight: navigationBarHeight, transition: .immediate)
        self.searchDisplayController?.activate(insertSubnode: { [weak self, weak placeholderNode] subnode, isSearchBar in
            if let strongSelf = self, let strongPlaceholderNode = placeholderNode {
                if isSearchBar {
                    strongPlaceholderNode.supernode?.insertSubnode(subnode, aboveSubnode: strongPlaceholderNode)
                } else {
                    strongSelf.insertSubnode(subnode, belowSubnode: navigationBar)
                }
            }
        }, placeholder: placeholderNode)
    }
    
    func prepareDeactivateSearch() {
        self.searchDisplayController?.isDeactivating = true
    }
    
    func deactivateSearch(placeholderNode: SearchBarPlaceholderNode) {
        if let searchDisplayController = self.searchDisplayController {
            searchDisplayController.deactivate(placeholder: placeholderNode)
            self.searchDisplayController = nil
        }
    }
    
    func animateIn(completion: @escaping () -> Void) {
        self.layer.animatePosition(from: CGPoint(x: self.layer.position.x, y: self.layer.position.y + self.layer.bounds.size.height), to: self.layer.position, duration: 0.5, timingFunction: kCAMediaTimingFunctionSpring, completion: { _ in
            completion()
        })
    }
    
    func animateOut(completion: (() -> Void)? = nil) {
        self.layer.animatePosition(from: self.layer.position, to: CGPoint(x: self.layer.position.x, y: self.layer.position.y + self.layer.bounds.size.height), duration: 0.2, timingFunction: CAMediaTimingFunctionName.easeInEaseOut.rawValue, removeOnCompletion: false, completion: { [weak self] _ in
            if let strongSelf = self {
                strongSelf.dismiss?()
            }
            completion?()
        })
    }
}

final class ContactSelectionCountPanelNode: ASDisplayNode {
    private let theme: PresentationTheme
    private let strings: PresentationStrings
    
    private let separatorNode: ASDisplayNode
    
    private let button: HighlightTrackingButtonNode
    private let badgeLabel: TextNode
    private var badgeText: NSAttributedString?
    private let badgeBackground: ASImageNode
    
    private let action: (() -> Void)
    
    private var validLayout: (CGFloat, CGFloat, CGFloat)?
    
    var count: Int = 0 {
        didSet {
            if self.count != oldValue && self.count > 0 {
                self.badgeText = NSAttributedString(string: "\(count)", font: Font.regular(14.0), textColor: self.theme.actionSheet.opaqueItemBackgroundColor, paragraphAlignment: .center)
                self.badgeLabel.isHidden = false
                self.badgeBackground.isHidden = false
                
                if let (width, sideInset, bottomInset) = self.validLayout {
                    let _ = self.updateLayout(width: width, sideInset: sideInset, bottomInset: bottomInset, transition: .immediate)
                }
            }
        }
    }
        
    init(theme: PresentationTheme, strings: PresentationStrings, action: @escaping () -> Void) {
        self.theme = theme
        self.strings = strings
        self.action = action

        self.separatorNode = ASDisplayNode()
        self.separatorNode.backgroundColor = theme.rootController.navigationBar.separatorColor
        
        self.badgeLabel = TextNode()
        self.badgeLabel.isHidden = true
        self.badgeLabel.isUserInteractionEnabled = false
        self.badgeLabel.displaysAsynchronously = false
        
        self.badgeBackground = ASImageNode()
        self.badgeBackground.isHidden = true
        self.badgeBackground.isLayerBacked = true
        self.badgeBackground.displaysAsynchronously = false
        self.badgeBackground.displayWithoutProcessing = true
        
        self.badgeBackground.image = generateStretchableFilledCircleImage(diameter: 22.0, color: theme.actionSheet.controlAccentColor)
        
        self.button = HighlightTrackingButtonNode()
        self.button.setTitle(strings.ShareMenu_Send, with: Font.medium(17.0), with: theme.actionSheet.controlAccentColor, for: .normal)
        
        super.init()
        
        self.backgroundColor = theme.rootController.navigationBar.opaqueBackgroundColor
        
        self.addSubnode(self.badgeBackground)
        self.addSubnode(self.badgeLabel)
        self.addSubnode(self.button)
        
        self.addSubnode(self.separatorNode)
        
        self.button.highligthedChanged = { [weak self] highlighted in
            if let strongSelf = self {
                if highlighted {
                    strongSelf.badgeBackground.layer.removeAnimation(forKey: "opacity")
                    strongSelf.badgeBackground.alpha = 0.4
                    
                    strongSelf.badgeLabel.layer.removeAnimation(forKey: "opacity")
                    strongSelf.badgeLabel.alpha = 0.4
                    
                    strongSelf.button.titleNode.layer.removeAnimation(forKey: "opacity")
                    strongSelf.button.titleNode.alpha = 0.4
                } else {
                    strongSelf.badgeBackground.alpha = 1.0
                    strongSelf.badgeBackground.layer.animateAlpha(from: 0.4, to: 1.0, duration: 0.2)
                    
                    strongSelf.badgeLabel.alpha = 1.0
                    strongSelf.badgeLabel.layer.animateAlpha(from: 0.4, to: 1.0, duration: 0.2)
                    
                    strongSelf.button.titleNode.alpha = 1.0
                    strongSelf.button.titleNode.layer.animateAlpha(from: 0.4, to: 1.0, duration: 0.2)
                }
            }
        }
        self.button.addTarget(self, action: #selector(self.pressed), forControlEvents: .touchUpInside)
    }
    
    @objc private func pressed() {
        self.action()
    }
    
    func updateLayout(width: CGFloat, sideInset: CGFloat, bottomInset: CGFloat, transition: ContainedViewLayoutTransition) -> CGFloat {
        self.validLayout = (width, sideInset, bottomInset)
        let topInset: CGFloat = 9.0
        var bottomInset = bottomInset
        bottomInset += topInset - (bottomInset.isZero ? 0.0 : 4.0)
            
        let height = 44.0 + bottomInset
        
        self.button.frame = CGRect(x: sideInset, y: 0.0, width: width - sideInset * 2.0, height: 44.0)
        
        if !self.badgeLabel.isHidden {
            let (badgeLayout, badgeApply) = TextNode.asyncLayout(self.badgeLabel)(TextNodeLayoutArguments(attributedString: self.badgeText, backgroundColor: nil, maximumNumberOfLines: 1, truncationType: .end, constrainedSize: CGSize(width: 100.0, height: 100.0), alignment: .left, lineSpacing: 0.0, cutout: nil, insets: UIEdgeInsets()))
            let _ = badgeApply()
            
            let backgroundSize = CGSize(width: max(22.0, badgeLayout.size.width + 10.0 + 1.0), height: 22.0)
            let backgroundFrame = CGRect(origin: CGPoint(x: self.button.titleNode.frame.maxX + 6.0, y: self.button.bounds.size.height - 33.0), size: backgroundSize)
            
            self.badgeBackground.frame = backgroundFrame
            self.badgeLabel.frame = CGRect(origin: CGPoint(x: floorToScreenPixels(backgroundFrame.midX - badgeLayout.size.width / 2.0), y: backgroundFrame.minY + 3.0), size: badgeLayout.size)
        }
        
        transition.updateFrame(node: self.separatorNode, frame: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: width, height: UIScreenPixel)))
        
        return height
    }
}
