import Foundation
import UIKit
import Display
import AsyncDisplayKit
import SwiftSignalKit
import TelegramPresentationData
import ActivityIndicator

public enum ItemListSectionHeaderAccessoryTextColor {
    case generic
    case destructive
}

public struct ItemListSectionHeaderAccessoryText: Equatable {
    public let value: String
    public let color: ItemListSectionHeaderAccessoryTextColor
    public let icon: UIImage?
    
    public init(value: String, color: ItemListSectionHeaderAccessoryTextColor, icon: UIImage? = nil) {
        self.value = value
        self.color = color
        self.icon = icon
    }
}

public enum ItemListSectionHeaderActivityIndicator {
    case none
    case left
    case right
    
    public var hasActivity: Bool {
        switch self {
        case .left, .right:
            return true
        default:
            return false
        }
    }
}

public class ItemListSectionHeaderItem: ListViewItem, ItemListItem {
    public struct BadgeStyle: Equatable {
        public var background: UIColor
        public var foreground: UIColor
        
        public init(background: UIColor, foreground: UIColor) {
            self.background = background
            self.foreground = foreground
        }
    }
    
    let presentationData: ItemListPresentationData
    let text: String
    let badge: String?
    let badgeStyle: BadgeStyle?
    let multiline: Bool
    let activityIndicator: ItemListSectionHeaderActivityIndicator
    let accessoryText: ItemListSectionHeaderAccessoryText?
    let actionText: String?
    let action: (() -> Void)?
    public let sectionId: ItemListSectionId
    
    public let isAlwaysPlain: Bool = true
    
    public init(presentationData: ItemListPresentationData, text: String, badge: String? = nil, badgeStyle: BadgeStyle? = nil, multiline: Bool = false, activityIndicator: ItemListSectionHeaderActivityIndicator = .none, accessoryText: ItemListSectionHeaderAccessoryText? = nil, actionText: String? = nil, action: (() -> Void)? = nil, sectionId: ItemListSectionId) {
        self.presentationData = presentationData
        self.text = text
        self.badge = badge
        self.badgeStyle = badgeStyle
        self.multiline = multiline
        self.activityIndicator = activityIndicator
        self.accessoryText = accessoryText
        self.actionText = actionText
        self.action = action
        self.sectionId = sectionId
    }
    
    public func nodeConfiguredForParams(async: @escaping (@escaping () -> Void) -> Void, params: ListViewItemLayoutParams, synchronousLoads: Bool, previousItem: ListViewItem?, nextItem: ListViewItem?, completion: @escaping (ListViewItemNode, @escaping () -> (Signal<Void, NoError>?, (ListViewItemApply) -> Void)) -> Void) {
        async {
            let node = ItemListSectionHeaderItemNode()
            let (layout, apply) = node.asyncLayout()(self, params, itemListNeighbors(item: self, topItem: previousItem as? ItemListItem, bottomItem: nextItem as? ItemListItem))
            
            node.contentSize = layout.contentSize
            node.insets = layout.insets
            
            Queue.mainQueue().async {
                completion(node, {
                    return (nil, { _ in apply() })
                })
            }
        }
    }
    
    public func updateNode(async: @escaping (@escaping () -> Void) -> Void, node: @escaping () -> ListViewItemNode, params: ListViewItemLayoutParams, previousItem: ListViewItem?, nextItem: ListViewItem?, animation: ListViewItemUpdateAnimation, completion: @escaping (ListViewItemNodeLayout, @escaping (ListViewItemApply) -> Void) -> Void) {
        Queue.mainQueue().async {
            guard let nodeValue = node() as? ItemListSectionHeaderItemNode else {
                assertionFailure()
                return
            }
        
            let makeLayout = nodeValue.asyncLayout()
            async {
                let (layout, apply) = makeLayout(self, params, itemListNeighbors(item: self, topItem: previousItem as? ItemListItem, bottomItem: nextItem as? ItemListItem))
                Queue.mainQueue().async {
                    completion(layout, { _ in
                        apply()
                    })
                }
            }
        }
    }
}

public class ItemListSectionHeaderItemNode: ListViewItemNode {
    private var item: ItemListSectionHeaderItem?
    
    private let titleNode: TextNode
    private var badgeBackgroundLayer: SimpleLayer?
    private var badgeTextNode: TextNode?
    private let accessoryTextNode: TextNode
    private var accessoryImageNode: ASImageNode?
    private var activityIndicator: ActivityIndicator?
    private var actionNode: TextNode?
    private var actionButtonNode: HighlightableButtonNode?

    private let activateArea: AccessibilityAreaNode
    
    public init() {
        self.titleNode = TextNode()
        self.titleNode.isUserInteractionEnabled = false
        self.titleNode.contentMode = .left
        self.titleNode.contentsScale = UIScreen.main.scale
        
        self.accessoryTextNode = TextNode()
        self.accessoryTextNode.isUserInteractionEnabled = false
        self.accessoryTextNode.contentMode = .left
        self.accessoryTextNode.contentsScale = UIScreen.main.scale
        
        self.activateArea = AccessibilityAreaNode()
        self.activateArea.accessibilityTraits = [.staticText, .header]
        
        super.init(layerBacked: false, dynamicBounce: false)
        
        self.addSubnode(self.titleNode)
        self.addSubnode(self.accessoryTextNode)
        self.addSubnode(self.activateArea)
    }
    
    public func asyncLayout() -> (_ item: ItemListSectionHeaderItem, _ params: ListViewItemLayoutParams, _ neighbors: ItemListNeighbors) -> (ListViewItemNodeLayout, () -> Void) {
        let makeTitleLayout = TextNode.asyncLayout(self.titleNode)
        let makeActionLayout = TextNode.asyncLayout(self.actionNode)
        let makeBadgeTextLayout = TextNode.asyncLayout(self.badgeTextNode)
        let makeAccessoryTextLayout = TextNode.asyncLayout(self.accessoryTextNode)
        
        let previousItem = self.item
        
        return { item, params, neighbors in
            let leftInset: CGFloat = 15.0 + params.leftInset
            
            let titleFont = Font.regular(item.presentationData.fontSize.itemListBaseHeaderFontSize)
            
            var badgeLayoutAndApply: (TextNodeLayout, () -> TextNode)?
            if let badge = item.badge {
                if item.badgeStyle != nil {
                    let badgeFont = Font.regular(item.presentationData.fontSize.itemListBaseHeaderFontSize * 12.0 / 13.0)
                    badgeLayoutAndApply = makeBadgeTextLayout(TextNodeLayoutArguments(attributedString: NSAttributedString(string: badge, font: badgeFont, textColor: item.badgeStyle?.foreground ?? item.presentationData.theme.list.itemCheckColors.foregroundColor), maximumNumberOfLines: 1, truncationType: .end, constrainedSize: CGSize(width: 100.0, height: 100.0)))
                } else {
                    let badgeFont = Font.semibold(item.presentationData.fontSize.itemListBaseHeaderFontSize * 11.0 / 13.0)
                    badgeLayoutAndApply = makeBadgeTextLayout(TextNodeLayoutArguments(attributedString: NSAttributedString(string: badge, font: badgeFont, textColor: item.badgeStyle?.foreground ?? item.presentationData.theme.list.itemCheckColors.foregroundColor), maximumNumberOfLines: 1, truncationType: .end, constrainedSize: CGSize(width: 100.0, height: 100.0)))
                }
            }
            
            let badgeSpacing: CGFloat = 6.0
            var textRightInset: CGFloat = 20.0
            if let badgeLayoutAndApply {
                textRightInset += badgeLayoutAndApply.0.size.width + badgeSpacing
            }
            
            var actionLayoutAndApply: (TextNodeLayout, () -> TextNode)?
            if let actionText = item.actionText {
                let actionLayoutAndApplyValue = makeActionLayout(TextNodeLayoutArguments(attributedString: NSAttributedString(string: actionText, font: titleFont, textColor: item.presentationData.theme.list.itemAccentColor), backgroundColor: nil, maximumNumberOfLines: item.multiline ? 0 : 1, truncationType: .end, constrainedSize: CGSize(width: params.width - params.leftInset - params.rightInset - textRightInset, height: CGFloat.greatestFiniteMagnitude), alignment: .natural, cutout: nil, insets: UIEdgeInsets()))
                actionLayoutAndApply = actionLayoutAndApplyValue
                textRightInset += actionLayoutAndApplyValue.0.size.width + 2.0
            }
            
            let (titleLayout, titleApply) = makeTitleLayout(TextNodeLayoutArguments(attributedString: NSAttributedString(string: item.text, font: titleFont, textColor: item.presentationData.theme.list.sectionHeaderTextColor), backgroundColor: nil, maximumNumberOfLines: item.multiline ? 0 : 1, truncationType: .end, constrainedSize: CGSize(width: params.width - params.leftInset - params.rightInset - textRightInset, height: CGFloat.greatestFiniteMagnitude), alignment: .natural, cutout: nil, insets: UIEdgeInsets()))
            var accessoryTextString: NSAttributedString?
            var accessoryIcon: UIImage?
            if let accessoryText = item.accessoryText {
                let color: UIColor
                switch accessoryText.color {
                case .generic:
                    color = item.presentationData.theme.list.sectionHeaderTextColor
                case .destructive:
                    color = item.presentationData.theme.list.freeTextErrorColor
                }
                accessoryTextString = NSAttributedString(string: accessoryText.value, font: titleFont, textColor: color)
                accessoryIcon = accessoryText.icon
            }
            let (accessoryLayout, accessoryApply) = makeAccessoryTextLayout(TextNodeLayoutArguments(attributedString: accessoryTextString, backgroundColor: nil, maximumNumberOfLines: 1, truncationType: .end, constrainedSize: CGSize(width: params.width - params.leftInset - params.rightInset - 20.0, height: CGFloat.greatestFiniteMagnitude), alignment: .natural, cutout: nil, insets: UIEdgeInsets()))
            
            let contentSize: CGSize
            var insets = UIEdgeInsets()
            
            contentSize = CGSize(width: params.width, height: titleLayout.size.height + 13.0)
            switch neighbors.top {
                case .none:
                    insets.top += 24.0
                case .otherSection:
                    insets.top += 28.0
                default:
                    break
            }
            
            let layout = ListViewItemNodeLayout(contentSize: contentSize, insets: insets)
            
            return (layout, { [weak self] in
                if let strongSelf = self {
                    strongSelf.item = item
                    
                    let _ = titleApply()
                    let _ = accessoryApply()
                    
                    strongSelf.activateArea.frame = CGRect(origin: CGPoint(x: params.leftInset, y: 0.0), size: CGSize(width: params.width - params.leftInset - params.rightInset, height: layout.contentSize.height))
                    strongSelf.activateArea.accessibilityLabel = item.text
                    
                    strongSelf.titleNode.frame = CGRect(origin: CGPoint(x: leftInset, y: 7.0), size: titleLayout.size)
                    
                    if let (actionLayout, actionApply) = actionLayoutAndApply {
                        let actionButtonNode: HighlightableButtonNode
                        if let current = strongSelf.actionButtonNode {
                            actionButtonNode = current
                        } else {
                            actionButtonNode = HighlightableButtonNode()
                            strongSelf.actionButtonNode = actionButtonNode
                            actionButtonNode.hitTestSlop = UIEdgeInsets(top: -4.0, left: -4.0, bottom: -4.0, right: -4.0)
                            strongSelf.addSubnode(actionButtonNode)
                            actionButtonNode.addTarget(strongSelf, action: #selector(strongSelf.actionButtonPressed), forControlEvents: .touchUpInside)
                        }
                        
                        let actionNode = actionApply()
                        if strongSelf.actionNode !== actionNode {
                            strongSelf.actionNode?.removeFromSupernode()
                            strongSelf.actionNode = actionNode
                            actionButtonNode.addSubnode(actionNode)
                        }
                        
                        actionButtonNode.frame = CGRect(origin: CGPoint(x: params.width - leftInset - actionLayout.size.width, y: 7.0), size: actionLayout.size)
                        
                        actionNode.frame = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: actionLayout.size)
                    } else {
                        if let actionNode = strongSelf.actionNode {
                            strongSelf.actionNode = nil
                            actionNode.removeFromSupernode()
                        }
                        if let actionButtonNode = strongSelf.actionButtonNode {
                            strongSelf.actionButtonNode = nil
                            actionButtonNode.removeFromSupernode()
                        }
                    }
                    
                    if let badgeLayoutAndApply {
                        let badgeTextNode = badgeLayoutAndApply.1()
                        let badgeSideInset: CGFloat = 4.0
                        let badgeBackgroundSize: CGSize
                        if item.badgeStyle != nil {
                            badgeBackgroundSize = CGSize(width: badgeSideInset * 2.0 + badgeLayoutAndApply.0.size.width, height: badgeLayoutAndApply.0.size.height + 3.0)
                        } else {
                            badgeBackgroundSize = CGSize(width: badgeSideInset * 2.0 + badgeLayoutAndApply.0.size.width, height: badgeLayoutAndApply.0.size.height + 3.0)
                        }
                        let badgeBackgroundFrame = CGRect(origin: CGPoint(x: strongSelf.titleNode.frame.maxX + badgeSpacing, y: strongSelf.titleNode.frame.minY - UIScreenPixel + floorToScreenPixels((strongSelf.titleNode.bounds.height - badgeBackgroundSize.height) * 0.5)), size: badgeBackgroundSize)
                        
                        let badgeBackgroundLayer: SimpleLayer
                        if let current = strongSelf.badgeBackgroundLayer {
                            badgeBackgroundLayer = current
                        } else {
                            badgeBackgroundLayer = SimpleLayer()
                            strongSelf.badgeBackgroundLayer = badgeBackgroundLayer
                            strongSelf.layer.addSublayer(badgeBackgroundLayer)
                        }
                        
                        if strongSelf.badgeTextNode !== badgeTextNode {
                            strongSelf.badgeTextNode?.removeFromSupernode()
                            strongSelf.badgeTextNode = badgeTextNode
                            strongSelf.addSubnode(badgeTextNode)
                        }
                        
                        badgeBackgroundLayer.frame = badgeBackgroundFrame
                        badgeBackgroundLayer.backgroundColor = item.badgeStyle?.background.cgColor ?? item.presentationData.theme.list.itemCheckColors.fillColor.cgColor
                        badgeBackgroundLayer.cornerRadius = 5.0
                        
                        badgeTextNode.frame = CGRect(origin: CGPoint(x: badgeBackgroundFrame.minX + floor((badgeBackgroundFrame.width - badgeLayoutAndApply.0.size.width) * 0.5), y: badgeBackgroundFrame.minY + 1.0 + floorToScreenPixels((badgeBackgroundFrame.height - badgeLayoutAndApply.0.size.height) * 0.5)), size: badgeLayoutAndApply.0.size)
                    } else {
                        if let badgeTextNode = strongSelf.badgeTextNode {
                            strongSelf.badgeTextNode = nil
                            badgeTextNode.removeFromSupernode()
                        }
                        if let badgeBackgroundLayer = strongSelf.badgeBackgroundLayer {
                            strongSelf.badgeBackgroundLayer = nil
                            badgeBackgroundLayer.removeFromSuperlayer()
                        }
                    }
                    
                    var accessoryTextOffset: CGFloat = 0.0
                    if let accessoryIcon = accessoryIcon {
                        accessoryTextOffset += accessoryIcon.size.width + 3.0
                    }
                    strongSelf.accessoryTextNode.frame = CGRect(origin: CGPoint(x: params.width - leftInset - accessoryLayout.size.width - accessoryTextOffset, y: 7.0), size: accessoryLayout.size)
                    
                    if let accessoryIcon = accessoryIcon {
                        let accessoryImageNode: ASImageNode
                        if let currentAccessoryImageNode = strongSelf.accessoryImageNode {
                            accessoryImageNode = currentAccessoryImageNode
                        } else {
                            accessoryImageNode = ASImageNode()
                            accessoryImageNode.displaysAsynchronously = false
                            accessoryImageNode.displayWithoutProcessing = true
                            strongSelf.addSubnode(accessoryImageNode)
                            strongSelf.accessoryImageNode = accessoryImageNode
                        }
                        accessoryImageNode.image = accessoryIcon
                        accessoryImageNode.frame = CGRect(origin: CGPoint(x: params.width - leftInset - accessoryIcon.size.width, y: 7.0), size: accessoryIcon.size)
                    } else if let accessoryImageNode = strongSelf.accessoryImageNode {
                        accessoryImageNode.removeFromSupernode()
                        strongSelf.accessoryImageNode = nil
                    }
                    
                    if previousItem?.activityIndicator != item.activityIndicator {
                        if item.activityIndicator.hasActivity {
                            let activityIndicator: ActivityIndicator
                            if let currentActivityIndicator = strongSelf.activityIndicator {
                                activityIndicator = currentActivityIndicator
                            } else {
                                activityIndicator = ActivityIndicator(type: .custom(item.presentationData.theme.list.sectionHeaderTextColor, 18.0, 1.0, false))
                                strongSelf.addSubnode(activityIndicator)
                                strongSelf.activityIndicator = activityIndicator
                            }
                            activityIndicator.isHidden = false
                            if previousItem != nil {
                                activityIndicator.layer.animateAlpha(from: 0.0, to: 1.0, duration: 0.2, removeOnCompletion: false)
                            }
                        } else if let activityIndicator = strongSelf.activityIndicator {
                            activityIndicator.layer.animateAlpha(from: 1.0, to: 0.0, duration: 0.3, removeOnCompletion: false, completion: { finished in
                                if finished {
                                    activityIndicator.isHidden = true
                                }
                            })
                        }
                    }
                    
                    var activityIndicatorOrigin: CGPoint?
                    switch item.activityIndicator {
                    case .left:
                        activityIndicatorOrigin = CGPoint(x: strongSelf.titleNode.frame.maxX + 6.0, y: 7.0 - UIScreenPixel)
                    case .right:
                        activityIndicatorOrigin = CGPoint(x: params.width - leftInset - 18.0, y: 7.0 - UIScreenPixel)
                    default:
                        break
                    }
                    if let activityIndicatorOrigin = activityIndicatorOrigin {
                        strongSelf.activityIndicator?.frame = CGRect(origin: activityIndicatorOrigin, size: CGSize(width: 18.0, height: 18.0))
                    }
                }
            })
        }
    }
    
    @objc private func actionButtonPressed() {
        self.item?.action?()
    }
    
    override public func animateInsertion(_ currentTimestamp: Double, duration: Double, options: ListViewItemAnimationOptions) {
        self.layer.animateAlpha(from: 0.0, to: 1.0, duration: 0.4)
    }
    
    override public func animateRemoved(_ currentTimestamp: Double, duration: Double) {
        self.layer.animateAlpha(from: 1.0, to: 0.0, duration: 0.15, removeOnCompletion: false)
    }
}
