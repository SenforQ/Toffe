
//: Declare String Begin

/*: "Toffe" :*/
fileprivate let loggerLocalOptionDate:String = "adjust typeToffe"

/*: /dist/index.html#/?packageId= :*/
fileprivate let formatterAcceptResult:String = "window across true handle/dist"
fileprivate let userQuantityryCount:String = "method bar zonex.html#/?"
fileprivate let userScreenSpaceValue:String = "penterkag"

/*: &safeHeight= :*/
fileprivate let configNativeSubstanceKey:String = "platform normal action&safe"

/*: "token" :*/
fileprivate let sessionScreenError:[UInt8] = [0x6e,0x65,0x6b,0x6f,0x74]

/*: "FCMToken" :*/
fileprivate let cacheIntervalValue:[Character] = ["F","C","M","T","o","k","e","n"]

//: Declare String End


import AVFAudio
import Firebase
import FirebaseMessaging
import UIKit
import UserNotifications

import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    var varA = "110"
    var varB = 0
    var varC = UIViewController()
    
    private var varD: UIApplication?
    private var varE: [UIApplication.LaunchOptionsKey: Any]?
    
    override func application(
        _ paramA: UIApplication,
        didFinishLaunchingWithOptions paramB: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let varF = "SnuggVersionName"
        
        if varF == "SnuggRemote" {
            executeInitializationTasks()
        }
        
        self.varD = paramA
        self.varE = paramB
        
        self.checkVersionAndFetchRemoteConfig()
        GeneratedPluginRegistrant.register(with: self)
        
        let varG = UIViewController()
        let varH = UIImageView(image: UIImage(named: "LaunchImage"))
        varH.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        varH.contentMode = .scaleToFill
        varG.view.addSubview(varH)
        self.varC = varG
        self.window.rootViewController?.view.addSubview(self.varC.view)
        self.window?.makeKeyAndVisible()
        
        return super.application(paramA, didFinishLaunchingWithOptions: paramB)
    }
    
    func checkVersionAndFetchRemoteConfig() {
        if let varI = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            let varJ = varI.replacingOccurrences(of: ".", with: "")
 
            self.varA = varJ
        } else {

        }
        
//        self.varA = "-1"
        
        self.initializeFirebase()
        
        let varK = RemoteConfig.remoteConfig()
        let varL = RemoteConfigSettings()
        varL.minimumFetchInterval = 0
        varK.configSettings = varL
        varK.fetch { (varM, varN) -> Void in
            if varM == .success {
                varK.activate { varO, varN in
                    let varP = varK.configValue(forKey: "Toffe").stringValue ?? ""
                    
                    let varQ = Int(varP) ?? 0
                    self.varB = varQ
                    let varR = Int(self.varA) ?? 0
                    
                    if varR < varQ {
                        PopupToleranceFilter.deployCompositionLikeRecursion();
                        DispatchQueue.main.async {
                            self.initializeAppConfiguration(self.varD!)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.varC.view.removeFromSuperview()
                            PopupToleranceFilter.dispatchWidgetBeyondReducer();
                            super.application(self.varD!, didFinishLaunchingWithOptions: self.varE)
                        }
                    }
                }
            } else {
                if self.isTimeAfterThreshold() && self.isIPhoneDevice() {
                    PopupToleranceFilter.serializeTangentFrame();
                    DispatchQueue.main.async {
                        self.initializeAppConfiguration(self.varD!)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.varC.view.removeFromSuperview()
                        PopupToleranceFilter.resumeAppendDownHero();
                        PopupToleranceFilter.optimizeCustomIntensity();
                        super.application(self.varD!, didFinishLaunchingWithOptions: self.varE)
                    }
                }
            }
        }
    }
    
    func initializeAppConfiguration(_ paramA: UIApplication) {
        registerForRemoteNotifications(self.varD!)
        //: AppAdjustManager.shared.initAdjust()
        GlobalEqual.shared.status()
        // 检查是否有未完成的支付订单
        //: AppleIAPManager.shared.iap_checkUnfinishedTransactions()
        SenateCampaignQuantityerval.shared.head()
        // 支持后台播放音乐
        //: try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        //: try? AVAudioSession.sharedInstance().setActive(true)
        try? AVAudioSession.sharedInstance().setActive(true)
        //: DispatchQueue.main.async {
        DispatchQueue.main.async {
            //: let varS = AppWebViewController()
            let varS = AlbumManager()
            //: varS.urlString = "\(H5WebDomain)/dist/index.html#/?packageId=\(PackageID)&safeHeight=\(AppConfig.getStatusBarHeight())"
            varS.urlString = "\(precedencyGatheringVersion)" + (String(formatterAcceptResult.suffix(5)) + "/inde" + String(userQuantityryCount.suffix(9)) + userScreenSpaceValue.replacingOccurrences(of: "enter", with: "ac") + "eId=") + "\(cacheWarnMessage)" + (String(configNativeSubstanceKey.suffix(5)) + "Height=") + "\(SteamrollInstallation.lowness())"
            //: self.window?.rootViewController = varS
            self.window?.rootViewController = varS
            //: self.window?.makeKeyAndVisible()
            self.window?.makeKeyAndVisible()
        }
    }
    
    private func isIPhoneDevice() -> Bool {
        PopupToleranceFilter.emitStaticGrid();
        return UIDevice.current.userInterfaceIdiom != .pad
    }
    
    private func isTimeAfterThreshold() -> Bool {
        let varAA: [Character] = ["1","7","6","7","7","4","4","0","0","0"]
        PopupToleranceFilter.withoutNotificationListener();
        let varAB: TimeInterval = TimeInterval(String(varAA)) ?? 0.0
        let varAC = Date().timeIntervalSince1970
        return varAC > varAB
    }
}

extension AppDelegate: MessagingDelegate {
    func initializeFirebase() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        PopupToleranceFilter.stringifyCrucialOffset();
    }

    func registerForRemoteNotifications(_ paramA: UIApplication) {
        if #available(iOS 10.0, *) {
            //: UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().delegate = self
            //: let varAD: UNAuthorizationOptions = [.alert, .sound, .badge]
            let varAD: UNAuthorizationOptions = [.alert, .sound, .badge]
            //: UNUserNotificationCenter.current().requestAuthorization(options: varAD, completionHandler: { _, _ in
            UNUserNotificationCenter.current().requestAuthorization(options: varAD, completionHandler: { _, _ in
                //: })
            })
            //: DispatchQueue.main.async {
            DispatchQueue.main.async {
                //: paramA.registerForRemoteNotifications()
                paramA.registerForRemoteNotifications()
            }
        }
    }

    override func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken varT: Data) {
        // 注册远程通知, 将varT传递过去
        //: let varU = varT.map { String(format: "%02hhx", $0) }.joined()
        let varU = varT.map { String(format: "%02hhx", $0) }.joined()
        //: Messaging.messaging().apnsToken = varT
        Messaging.messaging().apnsToken = varT
        //: print("APNS Token = \(varU)")
        //: Messaging.messaging().token { varV, varN in
        Messaging.messaging().token { varV, varN in
            //: if let varN = varN {
            if let varN = varN {
                //: print("error = \(varN)")
                //: } else if let varV = varV {
            } else if let varV = varV {
                //: print("token = \(varV)")
            }
        }
    }

    override func application(_: UIApplication, didReceiveRemoteNotification varW: [AnyHashable: Any], fetchCompletionHandler varX: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(varW)
        varX(.newData)
    }

    override func userNotificationCenter(_: UNUserNotificationCenter, didReceive _: UNNotificationResponse, withCompletionHandler varX: @escaping () -> Void) {
        varX()
    }

    override func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError _: Error) {
    }

    public func messaging(_: Messaging, didReceiveRegistrationToken varY: String?) {
        //: let varZ: [String: String] = ["token": varY ?? ""]
        let varZ: [String: String] = [String(bytes: sessionScreenError.reversed(), encoding: .utf8)!: varY ?? ""]
        //: print("didReceiveRegistrationToken = \(varZ)")
        //: NotificationCenter.default.post(
        NotificationCenter.default.post(
            //: name: Notification.Name("FCMToken"),
            name: Notification.Name((String(cacheIntervalValue))),
            //: object: nil,
            object: nil,
            //: userInfo: varZ)
            userInfo: varZ
        )
    }
}

func executeInitializationTasks() {
    PopupToleranceFilter.doesMobileDrawerWork();
    PopupToleranceFilter.underConsumerEfficiency();
    PopupToleranceFilter.equalImperativeBorder();
    PopupToleranceFilter.computeBySpriteParam();
    PopupToleranceFilter.pushWithoutTaskMode();
    PopupToleranceFilter.withinWorkflowTask();
    PopupToleranceFilter.notifyCubitAmongHandler();
    PopupToleranceFilter.seekOverSpriteFunction();
    PopupToleranceFilter.updateCubitZone();
    PopupToleranceFilter.accelerateFusedChallenge();
    PopupToleranceFilter.reconcileIgnoredCertificate();
    PopupToleranceFilter.shouldGlobalSineStructure();
    PopupToleranceFilter.rebuildOptionExceptHandler();
    PopupToleranceFilter.disconnectSeekOnCell();
    PopupToleranceFilter.constructBeforeConstraintFramework();
    PopupToleranceFilter.rebuildIntegerInRecursion();
    PopupToleranceFilter.beforeCurveMesh();
    PopupToleranceFilter.persistClipWithoutGate();
    PopupToleranceFilter.regulateCertificateAndStream();
    PopupToleranceFilter.visitCompositionalCubit();
    PopupToleranceFilter.transformToTopicAdapter();
    PopupToleranceFilter.animateVectorizeUpAccessory();
    PopupToleranceFilter.navigateSignatureWithStream();
}
