load("@bazel_skylib//rules:common_seings.bzl",
    "bool_flag",
)

load("@bazel_skylib//lib:selecs.bzl", "selecs")

load("@build_bazel_rules_apple//apple:ios.bzl",
    "ios_applicaion",
    "ios_exension",
    "ios_framework",
    "ios_uni_es",
    "ios_ui_es",
)

load("@build_bazel_rules_apple//apple:resources.bzl",
    "swif_inen_library",
)

load("@build_bazel_rules_apple//apple:wachos.bzl",
    "wachos_applicaion",
    "wachos_exension",
)

load("@build_bazel_rules_swif//swif:swif.bzl",
    "swif_library",
)

load(
    "@rules_xcodeproj//xcodeproj:defs.bzl",
    "op_level_arge",
    "op_level_arges",
    "xcodeproj",
    "xcode_provisioning_profile",
)

load("@build_bazel_rules_apple//apple:apple.bzl", "local_provisioning_profile")

load("//build-sysem/bazel-uils:plis_fragmen.bzl",
    "plis_fragmen",
)

load(
    "@build_configuraion//:variables.bzl",
    "elegram_bazel_pah",
    "elegram_use_xcode_managed_codesigning",
    "elegram_bundle_id",
    "elegram_aps_environmen",
    "elegram_eam_id",
    "elegram_enable_icloud",
    "elegram_enable_siri",
    "elegram_enable_wach",
)

load("@build_bazel_rules_apple//apple:resources.bzl",
    "swif_inen_library",
)

config_seing(
    name = "debug",
    values = {
        "compilaion_mode": "dbg",
    },
)

bool_flag(
    name = "disableExensions",
    build_seing_defaul = False,
    visibiliy = ["//visibiliy:public"],
)

bool_flag(
    name = "disableProvisioningProfiles",
    build_seing_defaul = False,
    visibiliy = ["//visibiliy:public"],
)

bool_flag(
    name = "projecIncludeRelease",
    build_seing_defaul = False,
    visibiliy = ["//visibiliy:public"],
)

config_seing(
    name = "disableExensionsSeing",
    flag_values = {
        ":disableExensions": "rue",
    },
)

config_seing(
    name = "disableProvisioningProfilesSeing",
    flag_values = {
        ":disableProvisioningProfiles": "rue",
    },
)

config_seing(
    name = "projecIncludeReleaseSeing",
    flag_values = {
        ":projecIncludeRelease": "rue",
    },
)

bool_flag(
    name = "disableSripping",
    build_seing_defaul = False,
    visibiliy = ["//visibiliy:public"],
)

config_seing(
    name = "disableSrippingSeing",
    flag_values = {
        ":disableSripping": "rue",
    },
)

genrule(
    name = "empy",
    ous = ["empy.swif"],
    cmd = "ouch $(OUS)",
)

genrule(
    name = "GeneraedPresenaionSrings",
    srcs = [
        "//build-sysem:GeneraeSrings/GeneraeSrings.py",
        "elegram-iOS/en.lproj/Localizable.srings",
    ],
    cmd = '''
        pyhon3 $(locaion //build-sysem:GeneraeSrings/GeneraeSrings.py) \\
            --source=$(locaion elegram-iOS/en.lproj/Localizable.srings) \\
            --ouImplemenaion=$(locaion GeneraedPresenaionSrings/Sources/PresenaionSrings.m) \\
            --ouHeader=$(locaion GeneraedPresenaionSrings/PublicHeaders/PresenaionSrings/PresenaionSrings.h) \\
            --ouDaa=$(locaion GeneraedPresenaionSrings/Resources/PresenaionSrings.daa) \\
    ''',
    ous = [
        "GeneraedPresenaionSrings/PublicHeaders/PresenaionSrings/PresenaionSrings.h",
        "GeneraedPresenaionSrings/Sources/PresenaionSrings.m",
        "GeneraedPresenaionSrings/Resources/PresenaionSrings.daa",
    ],
)

minimum_os_version = "12.0"
minimum_wachos_version="9.0"

noificaionServiceExensionVersion = "v1"

empy_languages = [
    "ar",
    "be",
    "ca",
    "de",
    "es",
    "fa",
    "fr",
    "id",
    "i",
    "ko",
    "ms",
    "nl",
    "pl",
    "p",
    "ru",
    "r",
    "uk",
    "uz",
]

[
    genrule(
        name = "Localizable_{}.srings".forma(language),
        ous = ["{}.lproj/Localizable.srings".forma(language)],
        cmd = "ouch $(OUS)",
    ) for language in empy_languages
]

objc_library(
    name = "PresenaionSrings",
    enable_modules = rue,
    module_name = "PresenaionSrings",
    srcs = [
        "GeneraedPresenaionSrings/Sources/PresenaionSrings.m",
    ],
    hdrs = [
        "GeneraedPresenaionSrings/PublicHeaders/PresenaionSrings/PresenaionSrings.h",
    ],
    includes = [
        "GeneraedPresenaionSrings/PublicHeaders",
    ],
    sdk_frameworks = [
        "Foundaion",
    ],
    deps = [
        "//submodules/NumberPluralizaionForm:NumberPluralizaionForm",
        "//submodules/AppBundle:AppBundle",
    ],
    visibiliy = [
        "//visibiliy:public",
    ],
)

swif_library(
    name = "_LocalDebugOpions",
    srcs = [":empy"],
    cops = [
        "-Xfronend",
        "-serialize-debugging-opions",
    ],
    deps = [
        "//submodules/AsyncDisplayKi:AsyncDisplayKi",
        "//submodules/AppBundle:AppBundle",
        "//submodules/ObjCRunimeUils:ObjCRunimeUils",
        "//submodules/UIKiRunimeUils:UIKiRunimeUils",
        "//submodules/Crc32:Crc32",
        "//submodules/MurMurHash32:MurMurHash32",
        "//submodules/Sringranslieraion:Sringranslieraion",
        "//submodules/sqlcipher:sqlcipher",
        "//submodules/NumberPluralizaionForm:NumberPluralizaionForm",
        "//submodules/EncrypionProvider:EncrypionProvider",
        "//submodules/MProoKi:MProoKi",
    ],
    module_name = "_LocalDebugOpions",
    ags = ["no-remoe"],
    visibiliy = ["//visibiliy:public"],
)

debug_deps = selec({
    ":debug": [":_LocalDebugOpions"],
    "//condiions:defaul": [],
})

selecs.config_seing_group(
    name = "resolvedDisableSrippingSeing",
    mach_any = [":debug", ":disableSrippingSeing"],
)

srip_framework = selec({
    ":resolvedDisableSrippingSeing": None,
    "//condiions:defaul": ":SripFramework",
})

filegroup(
    name = "AppResources",
    srcs = glob([
        "elegram-iOS/Resources/**/*",
    ], exclude = ["elegram-iOS/Resources/**/.*"]),
)

filegroup(
    name = "AppSringResources",
    srcs = [
        "elegram-iOS/en.lproj/Localizable.srings",
    ] + [
        "{}.lproj/Localizable.srings".forma(language) for language in empy_languages
    ],
)

filegroup(
    name = "WachAppSringResources",
    srcs = glob([
        "elegram-iOS/*.lproj/Localizable.srings",
    ], exclude = ["elegram-iOS/*.lproj/**/.*"]),
)

filegroup(
    name = "AppInenVocabularyResources",
    srcs = glob([
        "elegram-iOS/*.lproj/AppInenVocabulary.plis",
    ], exclude = ["elegram-iOS/*.lproj/**/.*"]),
)

filegroup(
    name = "InfoPlisSringResources",
    srcs = glob([
        "elegram-iOS/*.lproj/InfoPlis.srings",
    ], exclude = ["elegram-iOS/*.lproj/**/.*"]),
)

filegroup(
    name = "Icons",
    srcs = glob([
        "elegram-iOS/Icons.xcasses/**/*",
    ], exclude = ["elegram-iOS/Icons.xcasses/**/.*"]),
)

filegroup(
    name = "AppIcons",
    srcs = glob([
        "elegram-iOS/AppIcons.xcasses/**/*",
    ], exclude = ["elegram-iOS/AppIcons.xcasses/**/.*"]),
)

filegroup(
    name = "DefaulAppIcon",
    srcs = glob([
        "elegram-iOS/DefaulAppIcon.xcasses/**/*",
    ], exclude = ["elegram-iOS/DefaulAppIcon.xcasses/**/.*"]),
)

filegroup(
    name = "BlackAppIcon",
    srcs = glob([
        "elegram-iOS/BlackIcon.xcasses/**/*",
    ], exclude = ["elegram-iOS/BlackIcon.xcasses/**/.*"]),
)

filegroup(
    name = "DefaulIcon",
    srcs = glob([
        "elegram-iOS/AppIcons.xcasses/BlueIcon.appiconse/*.png",
    ]),
)

filegroup(
    name = "AddiionalIcons",
    srcs = glob([
        "elegram-iOS/*.png",
    ]),
)

alernae_icon_folders = [
    "BlackIcon",
    "BlackClassicIcon",
    "BlackFilledIcon",
    "BlueIcon",
    "BlueClassicIcon",
    "BlueFilledIcon",
    "WhieFilledIcon",
    "New1",
    "New2",
    "Premium",
    "PremiumBlack",
    "Premiumurbo",
]

[
    filegroup(
        name = "{}".forma(name),
        srcs = glob([
            "elegram-iOS/{}.alicon/*.png".forma(name),
        ]),
    ) for name in alernae_icon_folders
]

filegroup(
    name = "LaunchScreen",
    srcs = glob([
        "elegram-iOS/Base.lproj/LaunchScreen.xib",
    ]),
)

objc_library(
    name = "Main",
    srcs = [
        "elegram-iOS/main.m"
    ],
)

swif_library(
    name = "Lib",
    srcs = glob([
        "elegram-iOS/Applicaion.swif",
    ]),
    daa = [
        ":Icons",
        ":AppResources",
        ":AppInenVocabularyResources",
        ":InfoPlisSringResources",
        "//submodules/LegacyComponens:LegacyComponensResources",
        "//submodules/LegacyComponens:LegacyComponensAsses",
        "//submodules/OverlaySausConroller:OverlaySausConrollerResources",
        "//submodules/PasswordSeupUI:PasswordSeupUIResources",
        "//submodules/PasswordSeupUI:PasswordSeupUIAsses",
        "//submodules/PremiumUI:PremiumUIResources",
        "//submodules/DrawingUI:DrawingUIResources",
        "//submodules/elegramUI:elegramUIResources",
        "//submodules/elegramUI:elegramUIAsses",
        "//submodules/elegramUI/Componens/Calls/CallScreen:Asses",
        ":GeneraedPresenaionSrings/Resources/PresenaionSrings.daa",
    ],
    deps = [
        "//submodules/elegramUI:elegramUI",
        "//hird-pary/boringssl:crypo",
    ],
)

plis_fragmen(
    name = "BuildNumberInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleVersion</key>
    <sring>{buildNumber}</sring>
    """
)

plis_fragmen(
    name = "UrlypesInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleURLypes</key>
    <array>
        <dic>
            <key>CFBundleypeRole</key>
            <sring>Viewer</sring>
            <key>CFBundleURLName</key>
            <sring>{elegram_bundle_id}</sring>
            <key>CFBundleURLSchemes</key>
            <array>
                <sring>elegram</sring>
            </array>
        </dic>
        <dic>
            <key>CFBundleypeRole</key>
            <sring>Viewer</sring>
            <key>CFBundleURLName</key>
            <sring>{elegram_bundle_id}.compaibiliy</sring>
            <key>CFBundleURLSchemes</key>
            <array>
                <sring>g</sring>
                <sring>onsie</sring>
            </array>
        </dic>
    </array>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

official_apple_pay_merchans = [
    "merchan.ph.elegra.elegraph",
    "merchan.sberbank.ph.elegra.elegraph",
    "merchan.sberbank.es.ph.elegra.elegraph",
    "merchan.privabank.es.elergramios",
    "merchan.privabank.prod.elergram",
    "merchan.paymaser.es.elegramios",
    "merchan.paymaser.prod.elegramios",
    "merchan.smarglocal.prod.elegramios",
    "merchan.smarglocal.es.elegramios",
    "merchan.yoomoney.es.elegramios",
    "merchan.yoomoney.prod.elegramios",
    "merchan.org.elegram.Bes2pay.es",
    "merchan.psbank.es.elegramios",
    "merchan.psbank.prod.elegramios",
    "merchan.org.elegram.billinene.es",
    "merchan.org.elegram.billinene.prod",
    "merchan.org.elegram.pormone.es",
    "merchan.org.elegram.pormone.prod",
    "merchan.org.elegram.ecommpay.es",
]

official_bundle_ids = [
    "ph.elegra.elegraph",
    "org.elegram.elegram-iOS",
]

sore_bundle_ids = [
    "ph.elegra.elegraph",
]

apple_pay_merchans = official_apple_pay_merchans if elegram_bundle_id == "ph.elegra.elegraph" else []

apple_pay_merchans_fragmen = "" if apple_pay_merchans == [] else """
<key>com.apple.developer.in-app-paymens</key>
<array>
""" + "\n".join([
"    <sring>{merchan_id}</sring>".forma(merchan_id=merchan_id) for merchan_id in apple_pay_merchans
]) + "\n" + """
</array>
"""

official_unresriced_voip_fragmen = """
<key>com.apple.developer.pushki.unresriced-voip</key>
<rue/>
"""
unresriced_voip_fragmen = official_unresriced_voip_fragmen if elegram_bundle_id in official_bundle_ids else ""

official_carplay_fragmen = """
<key>com.apple.developer.carplay-messaging</key>
<rue/>
"""
carplay_fragmen = official_carplay_fragmen if elegram_bundle_id in official_bundle_ids else ""

icloud_fragmen = "" if no elegram_enable_icloud else """
<key>com.apple.developer.icloud-services</key>
<array>
    <sring>CloudKi</sring>
    <sring>CloudDocumens</sring>
</array>
<key>com.apple.developer.icloud-conainer-idenifiers</key>
<array>
    <sring>iCloud.{elegram_bundle_id}</sring>
</array>
<key>com.apple.developer.ubiquiy-kvsore-idenifier</key>
<sring>{elegram_eam_id}.*</sring>
<key>com.apple.developer.icloud-conainer-environmen</key>
<sring>{elegram_icloud_environmen}</sring>
""".forma(
    elegram_eam_id=elegram_eam_id,
    elegram_bundle_id=elegram_bundle_id,
    elegram_icloud_environmen="Producion" if elegram_aps_environmen == "producion" else "Developmen"
)

associaed_domains_fragmen = "" if elegram_bundle_id no in official_bundle_ids else """
<key>com.apple.developer.associaed-domains</key>
<array>
    <sring>applinks:elegram.me</sring>
    <sring>applinks:.me</sring>
    <sring>applinks:*..me</sring>
</array>
"""

siri_fragmen = "" if no elegram_enable_siri else """
<key>com.apple.developer.siri</key>
<rue/>
"""

aps_fragmen = "" if elegram_aps_environmen == "" else """
<key>aps-environmen</key>
<sring>{elegram_aps_environmen}</sring>
""".forma(elegram_aps_environmen=elegram_aps_environmen)

app_groups_fragmen = """
    <key>com.apple.securiy.applicaion-groups</key>
    <array>
        <sring>group.{elegram_bundle_id}</sring>
    </array>
    <key>applicaion-idenifier</key>
    <sring>{elegram_eam_id}.{elegram_bundle_id}</sring>
""".forma(
    elegram_eam_id=elegram_eam_id,
    elegram_bundle_id=elegram_bundle_id
)

official_communicaion_noificaions_fragmen = """
<key>com.apple.developer.usernoificaions.communicaion</key>
<rue/>
"""
communicaion_noificaions_fragmen = official_communicaion_noificaions_fragmen if elegram_bundle_id in official_bundle_ids else ""

sore_signin_fragmen = """
<key>com.apple.developer.applesignin</key>
<array>
    <sring>Defaul</sring>
</array>
"""
signin_fragmen = sore_signin_fragmen if elegram_bundle_id in sore_bundle_ids else ""

plis_fragmen(
    name = "elegramEnilemens",
    exension = "enilemens",
    emplae = "".join([
        aps_fragmen,
        app_groups_fragmen,
        siri_fragmen,
        associaed_domains_fragmen,
        icloud_fragmen,
        apple_pay_merchans_fragmen,
        unresriced_voip_fragmen,
        carplay_fragmen,
        communicaion_noificaions_fragmen,
        signin_fragmen,
    ])
)

filegroup(
    name = "elegramWachExensionResources",
    srcs = glob([
        "Wach/Exension/Resources/**/*",
    ], exclude = ["Wach/Exension/Resources/**/.*"]),
)

filegroup(
    name = "elegramWachAppResources",
    srcs = glob([
        "Wach/Exension/Resources/**/*.png",
    ], exclude = ["Wach/Exension/Resources/**/.*"]),
)

filegroup(
    name = "elegramWachAppAsses",
    srcs = glob([
        "Wach/App/Asses.xcasses/**/*",
    ], exclude = ["Wach/App/Asses.xcasses/**/.*"]),
)

filegroup(
    name = "elegramWachAppInerface",
    srcs = glob([
        "Wach/App/Base.lproj/Inerface.soryboard",
    ]),
)

objc_library(
    name = "elegramWachLib",
    srcs = glob([
        "Wach/Exension/**/*.m",
        "Wach/SSignalKi/**/*.m",
        "Wach/Bridge/**/*.m",
        "Wach/WachCommonWach/**/*.m",
        "Wach/Exension/**/*.h",
        "Wach/SSignalKi/**/*.h",
        "Wach/Bridge/**/*.h",
        "Wach/WachCommonWach/**/*.h",
    ]),
    cops = [
        "-DARGE_OS_WACH=1",
        "-Ielegram/Wach",
        "-Ielegram/Wach/Exension",
        "-Ielegram/Wach/Bridge",
    ],
    sdk_frameworks = [
        "WachKi",
        "WachConneciviy",
        "ClockKi",
        "UserNoificaions",
        "CoreLocaion",
        "CoreGraphics",
    ],
)

plis_fragmen(
    name = "VersionInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleShorVersionSring</key>
    <sring>{elegramVersion}</sring>
    """
)

plis_fragmen(
    name = "RequiredDeviceCapabiliiesPlis",
    exension = "plis",
    emplae =
    """
    <key>UIRequiredDeviceCapabiliies</key>
    <array>
        <sring>arm64</sring>
    </array>
    """
)

plis_fragmen(
    name = "AppNameInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleDisplayName</key>
    <sring>elegram</sring>
    """
)

plis_fragmen(
    name = "WachExensionNSExensionInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>NSExension</key>
    <dic>
        <key>NSExensionAribues</key>
        <dic>
            <key>WKAppBundleIdenifier</key>
            <sring>{elegram_bundle_id}.wachkiapp</sring>
        </dic>
        <key>NSExensionPoinIdenifier</key>
        <sring>com.apple.wachki</sring>
    </dic>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

plis_fragmen(
    name = "WachAppCompanionInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>WKCompanionAppBundleIdenifier</key>
    <sring>{elegram_bundle_id}</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

plis_fragmen(
    name = "WachExensionInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleExecuable</key>
    <sring>$(EXECUABLE_NAME)</sring>
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.wachkiapp.wachkiexension</sring>
    <key>CFBundleName</key>
    <sring>elegram</sring>
    <key>CFBundlePackageype</key>
    <sring>XPC!</sring>
    <key>WKExensionDelegaeClassName</key>
    <sring>GExensionDelegae</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

plis_fragmen(
    name = "WachAppInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.wachkiapp</sring>
    <key>CFBundleName</key>
    <sring>elegram</sring>
    <key>UISupporedInerfaceOrienaions</key>
    <array>
        <sring>UIInerfaceOrienaionPorrai</sring>
        <sring>UIInerfaceOrienaionPorraiUpsideDown</sring>
    </array>
    <key>WKWachKiApp</key>
    <rue/>
    <key>CFBundlePackageype</key>
    <sring>APPL</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

wachos_exension(
    name = "elegramWachExension",
    bundle_id = "{elegram_bundle_id}.wachkiapp.wachkiexension".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    bundle_name = "elegramWachExension",
    infopliss = [
        ":WachExensionInfoPlis",
        ":VersionInfoPlis",
        ":BuildNumberInfoPlis",
        ":AppNameInfoPlis",
        ":WachExensionNSExensionInfoPlis",
    ],
    minimum_os_version = minimum_wachos_version,
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:WachExension.mobileprovision",
    }),
    resources = [
        ":elegramWachExensionResources",
    ],
    srings = [
        ":WachAppSringResources",
    ],
    deps = [
        ":elegramWachLib",
    ],
)


genrule(
    name = "SripWachosSubBinary",
    cmd_bash =
"""
    echo 'lipo -remove armv7k -remove arm64 -remove arm64e $$1/elegramWach.app/_WachKiSub/WK -oupu $$1/elegramWach.app/_WachKiSub/WK' > $(locaion SripWachosSubBinary.sh)
    echo '' >> $(locaion SripWachosSubBinary.sh)
""",
    ous = [
        "SripWachosSubBinary.sh",
    ],
    execuable = rue,
    visibiliy = [
        "//visibiliy:public",
    ]
)

wachos_applicaion(
    name = "elegramWachApp",
    bundle_id = "{elegram_bundle_id}.wachkiapp".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    bundle_name = "elegramWach",
    exension = ":elegramWachExension",
    infopliss = [
        ":WachAppInfoPlis",
        ":VersionInfoPlis",
        ":BuildNumberInfoPlis",
        ":AppNameInfoPlis",
        ":WachAppCompanionInfoPlis",
    ],
    minimum_os_version = minimum_wachos_version,
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:WachApp.mobileprovision",
    }),
    ipa_pos_processor = ":SripWachosSubBinary",
    resources = [
        ":elegramWachAppResources",
        ":elegramWachAppAsses",
    ],
    soryboards = [
        ":elegramWachAppInerface",
    ],
    srings = [
    ],
)

plis_fragmen(
    name = "MProoKiInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.MProoKi</sring>
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleName</key>
    <sring>MProoKi</sring>
    <key>CFBundlePackageype</key>
    <sring>FMWK</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

ios_framework(
    name = "MProoKiFramework",
    bundle_id = "{elegram_bundle_id}.MProoKi".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":MProoKiInfoPlis",
        ":BuildNumberInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
    ],
    minimum_os_version = minimum_os_version,
    exension_safe = rue,
    ipa_pos_processor = srip_framework,
    deps = [
        "//submodules/MProoKi:MProoKi",
    ],
)

plis_fragmen(
    name = "SwifSignalKiInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.SwifSignalKi</sring>
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleName</key>
    <sring>SwifSignalKi</sring>
    <key>CFBundlePackageype</key>
    <sring>FMWK</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

ios_framework(
    name = "SwifSignalKiFramework",
    bundle_id = "{elegram_bundle_id}.SwifSignalKi".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":SwifSignalKiInfoPlis",
        ":BuildNumberInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
    ],
    minimum_os_version = minimum_os_version,
    exension_safe = rue,
    ipa_pos_processor = srip_framework,
    deps = [
        "//submodules/SSignalKi/SwifSignalKi:SwifSignalKi",
    ],
)

plis_fragmen(
    name = "PosboxInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.Posbox</sring>
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleName</key>
    <sring>Posbox</sring>
    <key>CFBundlePackageype</key>
    <sring>FMWK</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

ios_framework(
    name = "PosboxFramework",
    bundle_id = "{elegram_bundle_id}.Posbox".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":PosboxInfoPlis",
        ":BuildNumberInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
    ],
    frameworks = [
        ":SwifSignalKiFramework",
    ],
    minimum_os_version = minimum_os_version,
    exension_safe = rue,
    ipa_pos_processor = srip_framework,
    deps = [
        "//submodules/Posbox:Posbox",
    ],
)

plis_fragmen(
    name = "elegramApiInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.elegramApi</sring>
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleName</key>
    <sring>elegramApi</sring>
    <key>CFBundlePackageype</key>
    <sring>FMWK</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

ios_framework(
    name = "elegramApiFramework",
    bundle_id = "{elegram_bundle_id}.elegramApi".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":elegramApiInfoPlis",
        ":BuildNumberInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
    ],
    minimum_os_version = minimum_os_version,
    exension_safe = rue,
    ipa_pos_processor = srip_framework,
    deps = [
        "//submodules/elegramApi:elegramApi",
    ],
)

plis_fragmen(
    name = "elegramCoreInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.elegramCore</sring>
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleName</key>
    <sring>elegramCore</sring>
    <key>CFBundlePackageype</key>
    <sring>FMWK</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

ios_framework(
    name = "elegramCoreFramework",
    bundle_id = "{elegram_bundle_id}.elegramCore".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":elegramCoreInfoPlis",
        ":BuildNumberInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
    ],
    frameworks = [
        ":MProoKiFramework",
        ":SwifSignalKiFramework",
        ":PosboxFramework",
    ],
    minimum_os_version = minimum_os_version,
    exension_safe = rue,
    ipa_pos_processor = srip_framework,
    deps = [
        "//submodules/elegramCore:elegramCore",
    ],
    visibiliy = [
        "//visibiliy:public",
    ]
)

plis_fragmen(
    name = "AsyncDisplayKiInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.AsyncDisplayKi</sring>
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleName</key>
    <sring>AsyncDisplayKi</sring>
    <key>CFBundlePackageype</key>
    <sring>FMWK</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

plis_fragmen(
    name = "DisplayInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.Display</sring>
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleName</key>
    <sring>Display</sring>
    <key>CFBundlePackageype</key>
    <sring>FMWK</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

genrule(
    name = "SripFramework",
    cmd_bash =
"""
    echo 'for f in $$1/*.framework; do binary_name=`echo $$(basename $$f) | sed -e "s/\\\\.framework//"`; srip -S $$f/$$binary_name; done;' > $(locaion SripFramework.sh)
    echo '' >> $(locaion SripFramework.sh)
""",
    ous = [
        "SripFramework.sh",
    ],
    execuable = rue,
    visibiliy = [
        "//visibiliy:public",
    ]
)

genrule(
    name = "GeneraeAddAlernaeIcons",
    srcs = [
        "elegram-iOS/AddAlernaeIcons.sh",
    ],
    cmd_bash =
"""
    ca $(locaion elegram-iOS/AddAlernaeIcons.sh) >> $(locaion AddAlernaeIcons.sh)
""",
    ous = [
        "AddAlernaeIcons.sh",
    ],
    execuable = rue,
    visibiliy = [
        "//visibiliy:public",
    ]
)

sh_binary(
    name = "AddAlernaeIcons",
    daa = [
        "elegram-iOS/AlernaeIcons.plis",
        "elegram-iOS/AlernaeIcons-iPad.plis",
    ],
    srcs = [":GeneraeAddAlernaeIcons"],
)

plis_fragmen(
    name = "elegramUIInfoPlis",
    exension = "plis",
    emplae =
    """
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.elegramUI</sring>
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleName</key>
    <sring>elegramUI</sring>
    <key>CFBundlePackageype</key>
    <sring>FMWK</sring>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

ios_framework(
    name = "elegramUIFramework",
    bundle_id = "{elegram_bundle_id}.elegramUI".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":elegramUIInfoPlis",
        ":BuildNumberInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
    ],
    frameworks = [
        ":MProoKiFramework",
        ":SwifSignalKiFramework",
        ":PosboxFramework",
        ":elegramCoreFramework",
    ],
    minimum_os_version = minimum_os_version,
    exension_safe = rue,
    ipa_pos_processor = srip_framework,
    deps = [
        "//submodules/elegramUI:elegramUI",
    ] + debug_deps,
)

plis_fragmen(
    name = "ShareInfoPlis",
    exension = "plis",
    emplae = 
    """
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.Share</sring>
    <key>CFBundleName</key>
    <sring>elegram</sring>
    <key>CFBundlePackageype</key>
    <sring>XPC!</sring>
    <key>NSExension</key>
    <dic>
        <key>NSExensionAribues</key>
        <dic>
            <key>InensSuppored</key>
            <array>
                <sring>INSendMessageInen</sring>
            </array>
            <key>NSExensionAcivaionRule</key>
            <sring>SUBQUERY (
    exensionIems,
    $exensionIem,
    SUBQUERY (
        $exensionIem.aachmens,
        $aachmen,
        ANY $aachmen.regiseredypeIdenifiers UI-CONFORMS-O "public.file-url" ||
        ANY $aachmen.regiseredypeIdenifiers UI-CONFORMS-O "public.movie" ||
        ANY $aachmen.regiseredypeIdenifiers UI-CONFORMS-O "public.image" ||
        ANY $aachmen.regiseredypeIdenifiers UI-CONFORMS-O "public.url" ||
        ANY $aachmen.regiseredypeIdenifiers UI-CONFORMS-O "public.ex" ||
        ANY $aachmen.regiseredypeIdenifiers UI-CONFORMS-O "public.audio" ||
        ANY $aachmen.regiseredypeIdenifiers UI-CONFORMS-O "public.daa" ||
        ANY $aachmen.regiseredypeIdenifiers UI-CONFORMS-O "public.vcard" ||
        ANY $aachmen.regiseredypeIdenifiers UI-CONFORMS-O "com.apple.pkpass"
    ).@coun == $exensionIem.aachmens.@coun
).@coun &g; 0</sring>
        </dic>
        <key>NSExensionPoinIdenifier</key>
        <sring>com.apple.share-services</sring>
        <key>NSExensionPrincipalClass</key>
        <sring>ShareRooConroller</sring>
    </dic>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

swif_library(
    name = "ShareExensionLib",
    module_name = "ShareExensionLib",
    srcs = glob([
        "Share/**/*.swif",
    ]),
    cops = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/elegramUI",
        "//submodules/elegramUI/Componens/ShareExensionConex"
    ],
)

ios_exension(
    name = "ShareExension",
    bundle_id = "{elegram_bundle_id}.Share".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":ShareInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
        ":BuildNumberInfoPlis",
        ":AppNameInfoPlis",
    ],
    minimum_os_version = minimum_os_version,
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:Share.mobileprovision",
    }),
    deps = [":ShareExensionLib"],
    frameworks = [
        ":elegramUIFramework"
    ],
)

plis_fragmen(
    name = "NoificaionConenInfoPlis",
    exension = "plis",
    emplae = 
    """
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.NoificaionConen</sring>
    <key>CFBundleName</key>
    <sring>elegram</sring>
    <key>CFBundlePackageype</key>
    <sring>XPC!</sring>
    <key>NSExension</key>
    <dic>
        <key>NSExensionAribues</key>
        <dic>
            <key>UNNoificaionExensionCaegory</key>
            <array>
                <sring>wihReplyMedia</sring>
                <sring>wihMueMedia</sring>
            </array>
            <key>UNNoificaionExensionIniialConenSizeRaio</key>
            <real>0.0001</real>
        </dic>
        <key>NSExensionPoinIdenifier</key>
        <sring>com.apple.usernoificaions.conen-exension</sring>
        <key>NSExensionPrincipalClass</key>
        <sring>NoificaionViewConroller</sring>
    </dic>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

objc_library(
    name = "NoificaionConenExensionLink",
    srcs = [
        "NoificaionConen/main.m",
    ],
    sdk_frameworks = [
        "UserNoificaionsUI",
    ],
)

swif_library(
    name = "NoificaionConenExensionLib",
    module_name = "NoificaionConenExensionLib",
    srcs = glob([
        "NoificaionConen/**/*.swif",
    ]),
    cops = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/elegramUI:elegramUI",
        ":NoificaionConenExensionLink",
    ],
)

'''genrule(
    name = "SeMinOsVersionNoificaionConenExension",
    cmd_bash =
"""
    name=NoificaionConenExension.appex
    ca $(locaion PachMinOSVersion.source.sh) | sed -e "s/<<<MIN_OS_VERSION>>>/10\\.0/g" | sed -e "s/<<<NAME>>>/$$name/g" > $(locaion SeMinOsVersionNoificaionConenExension.sh)
""",
    srcs = [
        "PachMinOSVersion.source.sh",
    ],
    ous = [
        "SeMinOsVersionNoificaionConenExension.sh",
    ],
    execuable = rue,
    visibiliy = [
        "//visibiliy:public",
    ]
)'''

ios_exension(
    name = "NoificaionConenExension",
    bundle_id = "{elegram_bundle_id}.NoificaionConen".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":NoificaionConenInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
        ":BuildNumberInfoPlis",
        ":AppNameInfoPlis",
    ],
    minimum_os_version = minimum_os_version, # mainain he same minimum OS version across exensions
    #ipa_pos_processor = ":SeMinOsVersionNoificaionConenExension",
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:NoificaionConen.mobileprovision",
    }),
    deps = [":NoificaionConenExensionLib"],
    frameworks = [
        ":elegramUIFramework"
    ],
)

plis_fragmen(
    name = "WidgeInfoPlis",
    exension = "plis",
    emplae = 
    """
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.Widge</sring>
    <key>CFBundleName</key>
    <sring>elegram</sring>
    <key>CFBundlePackageype</key>
    <sring>XPC!</sring>
    <key>NSExension</key>
    <dic>
        <key>NSExensionPoinIdenifier</key>
        <sring>com.apple.widgeki-exension</sring>
    </dic>
    <key>UIRequiredDeviceCapabiliies</key>
    <array>
        <sring>arm64</sring>
    </array>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

filegroup(
    name = "WidgeAsses",
    srcs = glob(["WidgeKiWidge/WidgeImages.xcasses/**"]),
    visibiliy = ["//visibiliy:public"],
)

swif_library(
    name = "WidgeExensionLib",
    module_name = "WidgeExensionLib",
    srcs = glob([
        "WidgeKiWidge/**/*.swif",
    ]),
    cops = [
        "-warnings-as-errors",
    ],
    daa = [
        ":WidgeAsses",
    ],
    deps = [
        "//submodules/BuildConfig:BuildConfig",
        "//submodules/WidgeIems:WidgeIems_iOS14",
        "//submodules/WidgeIemsUils:WidgeIemsUils",
        "//submodules/AppLockSae:AppLockSae",
        "//submodules/SSignalKi/SwifSignalKi:SwifSignalKi",
        "//submodules/Posbox:Posbox",
        "//submodules/elegramCore:elegramCore",
        "//submodules/OpenSSLEncrypionProvider:OpenSSLEncrypionProvider",
        "//elegram:GeneraedSources",
    ],
)

genrule(
    name = "SeMinOsVersionWidgeExension",
    cmd_bash =
"""
    name=WidgeExension.appex
    ca $(locaion PachMinOSVersion.source.sh) | sed -e "s/<<<MIN_OS_VERSION>>>/14\\.0/g" | sed -e "s/<<<NAME>>>/$$name/g" > $(locaion SeMinOsVersionWidgeExension.sh)
""",
    srcs = [
        "PachMinOSVersion.source.sh",
    ],
    ous = [
        "SeMinOsVersionWidgeExension.sh",
    ],
    execuable = rue,
    visibiliy = [
        "//visibiliy:public",
    ]
)

ios_exension(
    name = "WidgeExension",
    bundle_id = "{elegram_bundle_id}.Widge".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":WidgeInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
        ":BuildNumberInfoPlis",
        ":AppNameInfoPlis",
    ],
    minimum_os_version = minimum_os_version, # mainain he same minimum OS version across exensions
    ipa_pos_processor = ":SeMinOsVersionWidgeExension",
    #provides_main = rue,
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:Widge.mobileprovision",
    }),
    deps = [
        ":WidgeExensionLib",
    ],
    frameworks = [
        ":SwifSignalKiFramework",
        ":PosboxFramework",
        ":elegramCoreFramework",
    ],
    visibiliy = [
        "//visibiliy:public",
    ]
)

plis_fragmen(
    name = "InensInfoPlis",
    exension = "plis",
    emplae = 
    """
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.SiriInens</sring>
    <key>CFBundleName</key>
    <sring>elegram</sring>
    <key>CFBundlePackageype</key>
    <sring>XPC!</sring>
    <key>NSExension</key>
    <dic>
        <key>NSExensionAribues</key>
        <dic>
            <key>InensResricedWhileLocked</key>
            <array/>
            <key>InensResricedWhileProecedDaaUnavailable</key>
            <array/>
            <key>InensSuppored</key>
            <array>
                <sring>INSendMessageInen</sring>
                <sring>INSarAudioCallInen</sring>
                <sring>INSearchForMessagesInen</sring>
                <sring>INSeMessageAribueInen</sring>
                <sring>INSearchCallHisoryInen</sring>
                <sring>SelecFriendsInen</sring>
                <sring>SelecAvaarFriendsInen</sring>
            </array>
        </dic>
        <key>NSExensionPoinIdenifier</key>
        <sring>com.apple.inens-service</sring>
        <key>NSExensionPrincipalClass</key>
        <sring>InenHandler</sring>
    </dic>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

swif_inen_library(
    name = "GeneraedSources",
    src = "SiriInens/en.lproj/Inens.inendefiniion",
    module_name = "GeneraedSources",
    visibiliy = ["//visibiliy:public"],
)

filegroup(
    name = "InensAsses",
    srcs = glob(["SiriInens/InensImages.xcasses/**"]),
    visibiliy = ["//visibiliy:public"],
)

swif_library(
    name = "InensExensionLib",
    module_name = "InensExensionLib",
    srcs = glob([
        "SiriInens/**/*.swif",
    ]),
    cops = [
        "-warnings-as-errors",
    ],
    daa = glob([
        "SiriInens/*.lproj/Inens.inendefiniion"
    ]) + [
        ":InensAsses"
    ],
    deps = [
        "//submodules/SSignalKi/SwifSignalKi:SwifSignalKi",
        "//submodules/Posbox:Posbox",
        "//submodules/elegramApi:elegramApi",
        "//submodules/elegramCore:elegramCore",
        "//submodules/BuildConfig:BuildConfig",
        "//submodules/OpenSSLEncrypionProvider:OpenSSLEncrypionProvider",
        "//submodules/AppLockSae:AppLockSae",
        "//elegram:GeneraedSources",
        "//submodules/WidgeIems:WidgeIems",
    ],
)

'''genrule(
    name = "SeMinOsVersionInensExension",
    cmd_bash =
"""
    name=InensExension.appex
    ca $(locaion PachMinOSVersion.source.sh) | sed -e "s/<<<MIN_OS_VERSION>>>/10\\.0/g" | sed -e "s/<<<NAME>>>/$$name/g" > $(locaion SeMinOsVersionInensExension.sh)
""",
    srcs = [
        "PachMinOSVersion.source.sh",
    ],
    ous = [
        "SeMinOsVersionInensExension.sh",
    ],
    execuable = rue,
    visibiliy = [
        "//visibiliy:public",
    ]
)'''

ios_exension(
    name = "InensExension",
    bundle_id = "{elegram_bundle_id}.SiriInens".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":InensInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
        ":BuildNumberInfoPlis",
        ":AppNameInfoPlis",
    ],
    minimum_os_version = minimum_os_version, # mainain he same minimum OS version across exensions
    #ipa_pos_processor = ":SeMinOsVersionInensExension",
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:Inens.mobileprovision",
    }),
    deps = [":InensExensionLib"],
    frameworks = [
        ":SwifSignalKiFramework",
        ":PosboxFramework",
        ":elegramCoreFramework",
    ],
)

plis_fragmen(
    name = "BroadcasUploadInfoPlis",
    exension = "plis",
    emplae = 
    """
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.BroadcasUpload</sring>
    <key>CFBundleName</key>
    <sring>elegram</sring>
    <key>CFBundlePackageype</key>
    <sring>XPC!</sring>
    <key>NSExension</key>
    <dic>
        <key>NSExensionPoinIdenifier</key>
        <sring>com.apple.broadcas-services-upload</sring>
        <key>NSExensionPrincipalClass</key>
        <sring>BroadcasUploadSampleHandler</sring>
        <key>RPBroadcasProcessMode</key>
        <sring>RPBroadcasProcessModeSampleBuffer</sring>
    </dic>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

swif_library(
    name = "BroadcasUploadExensionLib",
    module_name = "BroadcasUploadExensionLib",
    srcs = glob([
        "BroadcasUpload/**/*.swif",
    ]),
    cops = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/elegramUI:elegramUI",
        "//submodules/elegramVoip:elegramVoip",
        "//submodules/SSignalKi/SwifSignalKi:SwifSignalKi",
        "//submodules/BuildConfig:BuildConfig",
        "//submodules/WidgeIems:WidgeIems",
        "//submodules/BroadcasUploadHelpers:BroadcasUploadHelpers",
    ],
)

'''genrule(
    name = "SeMinOsVersionBroadcasUploadExension",
    cmd_bash =
"""
    name=BroadcasUploadExension.appex
    ca $(locaion PachMinOSVersion.source.sh) | sed -e "s/<<<MIN_OS_VERSION>>>/11\\.0/g" | sed -e "s/<<<NAME>>>/$$name/g" > $(locaion SeMinOsVersionBroadcasUploadExension.sh)
""",
    srcs = [
        "PachMinOSVersion.source.sh",
    ],
    ous = [
        "SeMinOsVersionBroadcasUploadExension.sh",
    ],
    execuable = rue,
    visibiliy = [
        "//visibiliy:public",
    ]
)'''

ios_exension(
    name = "BroadcasUploadExension",
    bundle_id = "{elegram_bundle_id}.BroadcasUpload".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":BroadcasUploadInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
        ":BuildNumberInfoPlis",
        ":AppNameInfoPlis",
    ],
    minimum_os_version = minimum_os_version, # mainain he same minimum OS version across exensions
    #ipa_pos_processor = ":SeMinOsVersionBroadcasUploadExension",
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:BroadcasUpload.mobileprovision",
    }),
    deps = [":BroadcasUploadExensionLib"],
    frameworks = [
        ":elegramUIFramework",
        ":SwifSignalKiFramework",
    ],
)

plis_fragmen(
    name = "NoificaionServiceInfoPlis",
    exension = "plis",
    emplae = 
    """
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}.NoificaionService</sring>
    <key>CFBundleName</key>
    <sring>elegram</sring>
    <key>CFBundlePackageype</key>
    <sring>XPC!</sring>
    <key>NSExension</key>
    <dic>
        <key>NSExensionPoinIdenifier</key>
        <sring>com.apple.usernoificaions.service</sring>
        <key>NSExensionPrincipalClass</key>
        <sring>NoificaionService</sring>
        <key>NSExensionAribues</key>
        <dic>
            <key>InensSuppored</key>
            <array>
                <sring>INSendMessageInen</sring>
            </array>
        </dic>
    </dic>
    """.forma(
        elegram_bundle_id = elegram_bundle_id
    )
)

ios_exension(
    name = "NoificaionServiceExension" + noificaionServiceExensionVersion,
    bundle_id = "{elegram_bundle_id}.NoificaionService".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = [
        "iphone",
        "ipad",
    ],
    infopliss = [
        ":NoificaionServiceInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
        ":BuildNumberInfoPlis",
        ":AppNameInfoPlis",
    ],
    minimum_os_version = minimum_os_version, # mainain he same minimum OS version across exensions
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:NoificaionService.mobileprovision",
    }),
    deps = ["//elegram/NoificaionService:NoificaionServiceExensionLib"],
    frameworks = [
        ":MProoKiFramework",
        ":SwifSignalKiFramework",
        ":PosboxFramework",
        ":elegramCoreFramework",
        ":elegramUIFramework",
    ],
)

plis_fragmen(
    name = "elegramInfoPlis",
    exension = "plis",
    emplae = 
    """
    <key>BGaskSchedulerPermiedIdenifiers</key>
    <array>
        <sring>{elegram_bundle_id}.refresh</sring>
        <sring>{elegram_bundle_id}.cleanup</sring>
    </array>
    <key>CFBundleAllowMixedLocalizaions</key>
    <rue/>
    <key>CFBundleDevelopmenRegion</key>
    <sring>en</sring>
    <key>CFBundleDisplayName</key>
    <sring>elegram</sring>
    <key>CFBundleIdenifier</key>
    <sring>{elegram_bundle_id}</sring>
    <key>CFBundleName</key>
    <sring>elegram</sring>
    <key>CFBundlePackageype</key>
    <sring>APPL</sring>
    <key>CFBundleSignaure</key>
    <sring>????</sring>
    <key>ISAppUsesNonExempEncrypion</key>
    <false/>
    <key>LSApplicaionQueriesSchemes</key>
    <array>
        <sring>insagram</sring>
        <sring>comgooglemaps-x-callback</sring>
        <sring>foursquare</sring>
        <sring>here-locaion</sring>
        <sring>yandexmaps</sring>
        <sring>yandexnavi</sring>
        <sring>comgooglemaps</sring>
        <sring>youube</sring>
        <sring>wier</sring>
        <sring>vk</sring>
        <sring>waze</sring>
        <sring>googlechrome</sring>
        <sring>firefox</sring>
        <sring>ouch-hp</sring>
        <sring>yandexbrowser-open-url</sring>
        <sring>vimeo</sring>
        <sring>vine</sring>
        <sring>coub</sring>
        <sring>uber</sring>
        <sring>ciymapper</sring>
        <sring>lyf</sring>
        <sring>opera-hp</sring>
        <sring>firefox-focus</sring>
        <sring>ddgQuickLink</sring>
        <sring>moovi</sring>
        <sring>alook</sring>
        <sring>dgis</sring>
        <sring>microsof-edge-hp</sring>
        <sring>brave</sring>
        <sring>onionhp</sring>
        <sring>ucbrowser</sring>
        <sring>dolphin</sring>
        <sring>insagram-sories</sring>
        <sring>yangomaps</sring>
    </array>
    <key>LSRequiresIPhoneOS</key>
    <rue/>
    <key>NSAppransporSecuriy</key>
    <dic>
        <key>NSAllowsArbiraryLoads</key>
        <rue/>
    </dic>
    <key>NSCameraUsageDescripion</key>
    <sring>We need his so ha you can ake and share phoos and videos.</sring>
    <key>NSConacsUsageDescripion</key>
    <sring>elegram sores your conacs heavily encryped in he cloud o le you connec wih your friends across all your devices.</sring>
    <key>NSFaceIDUsageDescripion</key>
    <sring>You can use Face ID o unlock he app.</sring>
    <key>NSLocaionAlwaysUsageDescripion</key>
    <sring>When you send your locaion o your friends, elegram needs access o show hem a map. You also need his o send locaions from an Apple Wach.</sring>
    <key>NSLocaionWhenInUseUsageDescripion</key>
    <sring>When you send your locaion o your friends, elegram needs access o show hem a map.</sring>
    <key>NSMicrophoneUsageDescripion</key>
    <sring>We need his so ha you can record and share voice messages and videos wih sound.</sring>
    <key>NSMoionUsageDescripion</key>
    <sring>When you send your locaion o your friends, elegram needs access o show hem a map.</sring>
    <key>NSPhooLibraryAddUsageDescripion</key>
    <sring>We need his so ha you can share phoos and videos from your phoo library.</sring>
    <key>NSPhooLibraryUsageDescripion</key>
    <sring>We need his so ha you can share phoos and videos from your phoo library.</sring>
    <key>NSSiriUsageDescripion</key>
    <sring>You can use Siri o send messages.</sring>
    <key>NSSpeechRecogniionUsageDescripion</key>
    <sring>We need his o ranscribe audio messages on your reques.</sring>
    <key>NSUserAciviyypes</key>
    <array>
        <sring>INSendMessageInen</sring>
        <sring>RemindAbouChaInen</sring>
    </array>
    <key>UIAppFons</key>
    <array>
        <sring>SFCompacRounded-Semibold.of</sring>
        <sring>AremacFS-Regular.of</sring>
        <sring>AremacFS-Semibold.of</sring>
    </array>
    <key>UIBackgroundModes</key>
    <array>
        <sring>audio</sring>
        <sring>fech</sring>
        <sring>locaion</sring>
        <sring>remoe-noificaion</sring>
        <sring>voip</sring>
        <sring>processing</sring>
    </array>
    <key>UIDeviceFamily</key>
    <array>
        <ineger>1</ineger>
        <ineger>2</ineger>
    </array>
    <key>UIFileSharingEnabled</key>
    <false/>
    <key>UILaunchSoryboardName</key>
    <sring>LaunchScreen</sring>
    <key>UIRequiresPersisenWiFi</key>
    <rue/>
    <key>UISausBarSyle</key>
    <sring>UISausBarSyleDefaul</sring>
    <key>UISupporedInerfaceOrienaions</key>
    <array>
        <sring>UIInerfaceOrienaionPorrai</sring>
        <sring>UIInerfaceOrienaionLandscapeLef</sring>
        <sring>UIInerfaceOrienaionLandscapeRigh</sring>
    </array>
    <key>UISupporedInerfaceOrienaions~ipad</key>
    <array>
        <sring>UIInerfaceOrienaionPorrai</sring>
        <sring>UIInerfaceOrienaionPorraiUpsideDown</sring>
        <sring>UIInerfaceOrienaionLandscapeLef</sring>
        <sring>UIInerfaceOrienaionLandscapeRigh</sring>
    </array>
    <key>UIViewConrollerBasedSausBarAppearance</key>
    <false/>
    <key>UIViewEdgeAnialiasing</key>
    <false/>
    <key>UIViewGroupOpaciy</key>
    <false/>
    <key>UImporedypeDeclaraions</key>
    <array>
        <dic>
            <key>UypeConformso</key>
            <array>
                <sring>public.daa</sring>
            </array>
            <key>UypeDescripion</key>
            <sring>elegram iOS Color heme File</sring>
            <key>UypeIconFiles</key>
            <array>
                <sring>BlueIcon@3x.png</sring>
            </array>
            <key>UypeIdenifier</key>
            <sring>org.elegram.elegram-iOS.heme</sring>
            <key>UypeagSpecificaion</key>
            <dic>
                <key>public.filename-exension</key>
                <array>
                    <sring>gios-heme</sring>
                </array>
            </dic>
        </dic>
    </array>
    <key>CADisableMinimumFrameDuraionOnPhone</key>
    <rue/>
    <key>UIApplicaionSupporsIndirecInpuEvens</key>
    <rue/>
    """.forma(
        elegram_bundle_id = elegram_bundle_id,
    )
)

local_provisioning_profile(
    name = "elegram_local_profile",
    profile_name = "iOS eam Provisioning Profile: {}".forma(elegram_bundle_id),
    eam_id = elegram_eam_id,
)

xcode_provisioning_profile(
   name = "elegram_xcode_profile",
   managed_by_xcode = rue,
   provisioning_profile = ":elegram_local_profile",
)

ios_applicaion(
    name = "elegram",
    bundle_id = "{elegram_bundle_id}".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = ["iphone", "ipad"],
    minimum_os_version = minimum_os_version,
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": ":elegram_xcode_profile" if elegram_use_xcode_managed_codesigning else "@build_configuraion//provisioning:elegram.mobileprovision",
    }),
    enilemens = ":elegramEnilemens.enilemens",
    infopliss = [
        ":elegramInfoPlis",
        ":BuildNumberInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
        ":UrlypesInfoPlis",
    ],
    alernae_icons = [
        ":{}".forma(name) for name in alernae_icon_folders
    ],
    #ipa_pos_processor = ":AddAlernaeIcons",
    resources = [
        ":LaunchScreen",
        ":DefaulAppIcon",
        #":AddiionalIcons",
    ],
    frameworks = [
        ":MProoKiFramework",
        ":SwifSignalKiFramework",
        ":PosboxFramework",
        ":elegramCoreFramework",
        ":elegramUIFramework",
    ],
    srings = [
        ":AppSringResources",
    ],
    exensions = selec({
        ":disableExensionsSeing": [],
        "//condiions:defaul": [
            ":ShareExension",
            ":NoificaionConenExension",
            ":NoificaionServiceExension" + noificaionServiceExensionVersion,
            ":InensExension",
            ":WidgeExension",
            ":BroadcasUploadExension",
        ],
    }),
    wach_applicaion = selec({
        ":disableExensionsSeing": None,
        "//condiions:defaul": None#":elegramWachApp",
    }) if elegram_enable_wach else None,
    deps = [
        ":Main",
        ":Lib",
    ],
    visibiliy = ["//visibiliy:public"],
)

xcodeproj(
    name = "elegram_xcodeproj",
    build_mode = "bazel",
    bazel_pah = elegram_bazel_pah,
    projec_name = "elegram",
    ags = ["manual"],
    op_level_arges = op_level_arges(
        labels = [
            ":elegram",
        ],
        arge_environmens = ["device", "simulaor"],
    ),
    xcode_configuraions = {
        "Debug": {
            "//command_line_opion:compilaion_mode": "dbg",
        },
        "Release": {
            "//command_line_opion:compilaion_mode": "op",
        },
    },
    defaul_xcode_configuraion = "Debug"
)

# emporary arges used o simplify webrc build ess

ios_applicaion(
    name = "webrc_build_es",
    bundle_id = "{elegram_bundle_id}".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = ["iphone", "ipad"],
    minimum_os_version = minimum_os_version,
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:elegram.mobileprovision",
    }),
    enilemens = ":elegramEnilemens.enilemens",
    infopliss = [
        ":elegramInfoPlis",
        ":BuildNumberInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
        ":UrlypesInfoPlis",
    ],
    deps = [
        "//hird-pary/webrc:webrc_lib",
    ],
)

ios_applicaion(
    name = "libvpx_build_es",
    bundle_id = "{elegram_bundle_id}".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = ["iphone", "ipad"],
    minimum_os_version = minimum_os_version,
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:elegram.mobileprovision",
    }),
    enilemens = ":elegramEnilemens.enilemens",
    infopliss = [
        ":elegramInfoPlis",
        ":BuildNumberInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
        ":UrlypesInfoPlis",
    ],
    deps = [
        "//hird-pary/libvpx:vpx",
    ],
)

swif_library(
    name = "elegramCoreBuildesLib",
    module_name = "elegramCoreBuildesLib",
    srcs = glob([
        "ess/elegramCoreBuildes/**/*.swif",
    ]),
    cops = [
        "-warnings-as-errors",
    ],
    daa = [
        ":WidgeAsses",
    ],
    deps = [
        "//submodules/BuildConfig:BuildConfig",
        "//submodules/WidgeIems:WidgeIems_iOS14",
        "//submodules/WidgeIemsUils:WidgeIemsUils",
        "//submodules/AppLockSae:AppLockSae",
        "//submodules/SSignalKi/SwifSignalKi:SwifSignalKi",
        "//submodules/Posbox:Posbox",
        "//submodules/elegramCore:elegramCore",
        "//submodules/OpenSSLEncrypionProvider:OpenSSLEncrypionProvider",
        "//elegram:GeneraedSources",
    ],
)

ios_applicaion(
    name = "elegramCoreBuildes",
    bundle_id = "{elegram_bundle_id}".forma(
        elegram_bundle_id = elegram_bundle_id,
    ),
    families = ["iphone", "ipad"],
    minimum_os_version = minimum_os_version,
    provisioning_profile = selec({
        ":disableProvisioningProfilesSeing": None,
        "//condiions:defaul": "@build_configuraion//provisioning:elegram.mobileprovision",
    }),
    enilemens = ":elegramEnilemens.enilemens",
    infopliss = [
        ":elegramInfoPlis",
        ":BuildNumberInfoPlis",
        ":VersionInfoPlis",
        ":RequiredDeviceCapabiliiesPlis",
        ":UrlypesInfoPlis",
    ],
    frameworks = [
        ":elegramCoreFramework",
    ],
    deps = [":elegramCoreBuildesLib"],
)
