
//: Declare String Begin

/*: "socoay" :*/
fileprivate let show_previousZoneID:String = "socoasession"

/*: "978" :*/
fileprivate let show_betweenProductNameMsg:[Character] = ["9","7","8"]

/*: "mwt08071ce80" :*/
fileprivate let sessionArrayDisappearMessage:String = "mwtshared"
fileprivate let app_blockError:String = "enginee80"

/*: "jjnsz9" :*/
fileprivate let sessionStyleAfterToken:String = "jjnobject"
fileprivate let responseModeURL:String = "flexible"

/*: "1.9.1" :*/
fileprivate let show_fullEarthMessage:[Character] = ["1",".","9",".","1"]

/*: "https://m. :*/
fileprivate let configStatusData:[Character] = ["h","t","t","p","s",":","/","/","m","."]

/*: .com" :*/
fileprivate let factoryBounceStr:[Character] = [".","c","o","m"]

/*: "CFBundleShortVersionString" :*/
fileprivate let mainNumericalCountResult:[Character] = ["C","F","B","u","n","d","l","e","S","h","o","r","t","V","e","r","s","i","o","n"]
fileprivate let actionPlatformResult:String = "mirror environment inputString"

/*: "CFBundleDisplayName" :*/
fileprivate let showGradeString:String = "cancelF"
fileprivate let main_openNativeFormat:[Character] = ["B","u","n","d","l","e","D","i","s","p","l","a","y","N","a","m","e"]

/*: "CFBundleVersion" :*/
fileprivate let managerTabSinceId:String = "CFBunexecute foundation engine screen"
fileprivate let data_selectID:String = "rsioinfo"

/*: "weixin" :*/
fileprivate let loggerLargePath:String = "WEIXIN"

/*: "wxwork" :*/
fileprivate let const_trackCount:String = "savewor"
fileprivate let mainOrbitStatus:[Character] = ["k"]

/*: "dingtalk" :*/
fileprivate let viewDeadlineStr:String = "dinmethoda"
fileprivate let mainTapOkUrl:String = "versionk"

/*: "lark" :*/
fileprivate let noti_labStr:[Character] = ["l","a","r","k"]

//: Declare String End

// __DEBUG__
// __CLOSE_PRINT__
//
//  SteamrollInstallation.swift
//  OverseaH5
//
//  Created by young on 2025/9/24.
//

//: import KeychainSwift
import KeychainSwift
//: import UIKit
import UIKit

/// 域名
//: let ReplaceUrlDomain = "socoay"
let showBroadsideId = (show_previousZoneID.replacingOccurrences(of: "session", with: "y"))
/// 包ID
//: let PackageID = "978"
let cacheWarnMessage = (String(show_betweenProductNameMsg))
/// Adjust
//: let AdjustKey = "mwt08071ce80"
let dataEarthString = (sessionArrayDisappearMessage.replacingOccurrences(of: "shared", with: "0") + "8071" + app_blockError.replacingOccurrences(of: "engine", with: "c"))
//: let AdInstallToken = "jjnsz9"
let constTextDismissState = (sessionStyleAfterToken.replacingOccurrences(of: "object", with: "sz") + responseModeURL.replacingOccurrences(of: "flexible", with: "9"))

/// 网络版本号
//: let AppNetVersion = "1.9.1"
let sessionLevelDate = (String(show_fullEarthMessage))
//: let H5WebDomain = "https://m.\(ReplaceUrlDomain).com"
let precedencyGatheringVersion = (String(configStatusData)) + "\(showBroadsideId)" + (String(factoryBounceStr))
//: let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let progressEmptyId = Bundle.main.infoDictionary![(String(mainNumericalCountResult) + String(actionPlatformResult.suffix(6)))] as! String
//: let AppBundle = Bundle.main.bundleIdentifier!
let helperOpticalLensKey = Bundle.main.bundleIdentifier!
//: let AppName = Bundle.main.infoDictionary!["CFBundleDisplayName"] ?? ""
let show_saveString = Bundle.main.infoDictionary![(showGradeString.replacingOccurrences(of: "cancel", with: "C") + String(main_openNativeFormat))] ?? ""
//: let AppBuildNumber = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
let data_appMode = Bundle.main.infoDictionary![(String(managerTabSinceId.prefix(5)) + "dleVe" + data_selectID.replacingOccurrences(of: "info", with: "n"))] as! String

//: class AppConfig: NSObject {
class SteamrollInstallation: NSObject {
    /// 获取状态栏高度
    //: class func getStatusBarHeight() -> CGFloat {
    class func lowness() -> CGFloat {
        //: if #available(iOS 13.0, *) {
        if #available(iOS 13.0, *) {
            //: if let statusBarManager = UIApplication.shared.windows.first?
            if let statusBarManager = UIApplication.shared.windows.first?
                //: .windowScene?.statusBarManager
                .windowScene?.statusBarManager
            {
                //: return statusBarManager.statusBarFrame.size.height
                return statusBarManager.statusBarFrame.size.height
            }
            //: } else {
        } else {
            //: return UIApplication.shared.statusBarFrame.size.height
            return UIApplication.shared.statusBarFrame.size.height
        }
        //: return 20.0
        return 20.0
    }

    /// 获取window
    //: class func getWindow() -> UIWindow {
    class func that() -> UIWindow {
        //: var window = UIApplication.shared.windows.first(where: {
        var window = UIApplication.shared.windows.first(where: {
            //: $0.isKeyWindow
            $0.isKeyWindow
            //: })
        })
        // 是否为当前显示的window
        //: if window?.windowLevel != UIWindow.Level.normal {
        if window?.windowLevel != UIWindow.Level.normal {
            //: let windows = UIApplication.shared.windows
            let windows = UIApplication.shared.windows
            //: for windowTemp in windows {
            for windowTemp in windows {
                //: if windowTemp.windowLevel == UIWindow.Level.normal {
                if windowTemp.windowLevel == UIWindow.Level.normal {
                    //: window = windowTemp
                    window = windowTemp
                    //: break
                    break
                }
            }
        }
        //: return window!
        return window!
    }

    /// 获取当前控制器
    //: class func currentViewController() -> (UIViewController?) {
    class func restaurantAttendant() -> (UIViewController?) {
        //: var window = AppConfig.getWindow()
        var window = SteamrollInstallation.that()
        //: if window.windowLevel != UIWindow.Level.normal {
        if window.windowLevel != UIWindow.Level.normal {
            //: let windows = UIApplication.shared.windows
            let windows = UIApplication.shared.windows
            //: for windowTemp in windows {
            for windowTemp in windows {
                //: if windowTemp.windowLevel == UIWindow.Level.normal {
                if windowTemp.windowLevel == UIWindow.Level.normal {
                    //: window = windowTemp
                    window = windowTemp
                    //: break
                    break
                }
            }
        }
        //: let vc = window.rootViewController
        let vc = window.rootViewController
        //: return currentViewController(vc)
        return model(vc)
    }

    //: class func currentViewController(_ vc: UIViewController?)
    class func model(_ vc: UIViewController?)
        //: -> UIViewController?
        -> UIViewController?
    {
        //: if vc == nil {
        if vc == nil {
            //: return nil
            return nil
        }
        //: if let presentVC = vc?.presentedViewController {
        if let presentVC = vc?.presentedViewController {
            //: return currentViewController(presentVC)
            return model(presentVC)
            //: } else if let tabVC = vc as? UITabBarController {
        } else if let tabVC = vc as? UITabBarController {
            //: if let selectVC = tabVC.selectedViewController {
            if let selectVC = tabVC.selectedViewController {
                //: return currentViewController(selectVC)
                return model(selectVC)
            }
            //: return nil
            return nil
            //: } else if let naiVC = vc as? UINavigationController {
        } else if let naiVC = vc as? UINavigationController {
            //: return currentViewController(naiVC.visibleViewController)
            return model(naiVC.visibleViewController)
            //: } else {
        } else {
            //: return vc
            return vc
        }
    }
}

// MARK: - Device

//: extension UIDevice {
extension UIDevice {
    //: static var modelName: String {
    static var modelName: String {
        //: var systemInfo = utsname()
        var systemInfo = utsname()
        //: uname(&systemInfo)
        uname(&systemInfo)
        //: let machineMirror = Mirror(reflecting: systemInfo.machine)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        //: let identifier = machineMirror.children.reduce("") {
        let identifier = machineMirror.children.reduce("") {
            //: identifier, element in
            identifier, element in
            //: guard let value = element.value as? Int8, value != 0 else {
            guard let value = element.value as? Int8, value != 0 else {
                //: return identifier
                return identifier
            }
            //: return identifier + String(UnicodeScalar(UInt8(value)))
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        //: return identifier
        return identifier
    }

    /// 获取当前系统时区
    //: static var timeZone: String {
    static var timeZone: String {
        //: let currentTimeZone = NSTimeZone.system
        let currentTimeZone = NSTimeZone.system
        //: return currentTimeZone.identifier
        return currentTimeZone.identifier
    }

    /// 获取当前系统语言
    //: static var langCode: String {
    static var langCode: String {
        //: let language = Locale.preferredLanguages.first
        let language = Locale.preferredLanguages.first
        //: return language ?? ""
        return language ?? ""
    }

    /// 获取接口语言
    //: static var interfaceLang: String {
    static var interfaceLang: String {
        //: let lang = UIDevice.getSystemLangCode()
        let lang = UIDevice.putDoing()
        //: if ["en", "ar", "es", "pt"].contains(lang) {
        if ["en", "ar", "es", "pt"].contains(lang) {
            //: return lang
            return lang
        }
        //: return "en"
        return "en"
    }

    /// 获取当前系统地区
    //: static var countryCode: String {
    static var countryCode: String {
        //: let locale = Locale.current
        let locale = Locale.current
        //: let countryCode = locale.regionCode
        let countryCode = locale.regionCode
        //: return countryCode ?? ""
        return countryCode ?? ""
    }

    /// 获取系统UUID（每次调用都会产生新值，所以需要keychain）
    //: static var systemUUID: String {
    static var systemUUID: String {
        //: let key = KeychainSwift()
        let key = KeychainSwift()
        //: if let value = key.get(AdjustKey) {
        if let value = key.get(dataEarthString) {
            //: return value
            return value
            //: } else {
        } else {
            //: let value = NSUUID().uuidString
            let value = NSUUID().uuidString
            //: key.set(value, forKey: AdjustKey)
            key.set(value, forKey: dataEarthString)
            //: return value
            return value
        }
    }

    /// 获取已安装应用信息
    //: static var getInstalledApps: String {
    static var getInstalledApps: String {
        //: var appsArr: [String] = []
        var appsArr: [String] = []
        //: if UIDevice.canOpenApp("weixin") {
        if UIDevice.activity((loggerLargePath.lowercased())) {
            //: appsArr.append("weixin")
            appsArr.append((loggerLargePath.lowercased()))
        }
        //: if UIDevice.canOpenApp("wxwork") {
        if UIDevice.activity((const_trackCount.replacingOccurrences(of: "save", with: "wx") + String(mainOrbitStatus))) {
            //: appsArr.append("wxwork")
            appsArr.append((const_trackCount.replacingOccurrences(of: "save", with: "wx") + String(mainOrbitStatus)))
        }
        //: if UIDevice.canOpenApp("dingtalk") {
        if UIDevice.activity((viewDeadlineStr.replacingOccurrences(of: "method", with: "gt") + mainTapOkUrl.replacingOccurrences(of: "version", with: "l"))) {
            //: appsArr.append("dingtalk")
            appsArr.append((viewDeadlineStr.replacingOccurrences(of: "method", with: "gt") + mainTapOkUrl.replacingOccurrences(of: "version", with: "l")))
        }
        //: if UIDevice.canOpenApp("lark") {
        if UIDevice.activity((String(noti_labStr))) {
            //: appsArr.append("lark")
            appsArr.append((String(noti_labStr)))
        }
        //: if appsArr.count > 0 {
        if appsArr.count > 0 {
            //: return appsArr.joined(separator: ",")
            return appsArr.joined(separator: ",")
        }
        //: return ""
        return ""
    }

    /// 判断是否安装app
    //: static func canOpenApp(_ scheme: String) -> Bool {
    static func activity(_ scheme: String) -> Bool {
        //: let url = URL(string: "\(scheme)://")!
        let url = URL(string: "\(scheme)://")!
        //: if UIApplication.shared.canOpenURL(url) {
        if UIApplication.shared.canOpenURL(url) {
            //: return true
            return true
        }
        //: return false
        return false
    }

    /// 获取系统语言
    /// - Returns: 国际通用语言Code
    //: @objc public class func getSystemLangCode() -> String {
    @objc public class func putDoing() -> String {
        //: let language = NSLocale.preferredLanguages.first
        let language = NSLocale.preferredLanguages.first
        //: let array = language?.components(separatedBy: "-")
        let array = language?.components(separatedBy: "-")
        //: return array?.first ?? "en"
        return array?.first ?? "en"
    }
}
