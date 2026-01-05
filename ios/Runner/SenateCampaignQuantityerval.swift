
//: Declare String Begin

/*: "mf/recharge/createApplePay" :*/
fileprivate let dataAddList:[Character] = ["m","f","/","r","e","c","h"]
fileprivate let formatterDecisionToken:[Character] = ["a","r","g","e","/","c","r","e","a"]
fileprivate let serviceAdjustmentStopData:[Character] = ["t","e","A","p","p","l","e","P","a","y"]

/*: "productId" :*/
fileprivate let appReflexCameraKey:String = "pwrittenod"
fileprivate let mainPoorKey:String = "source"

/*: "source" :*/
fileprivate let kUserOkKey:String = "onourc"
fileprivate let appLockupPresentationPath:String = "run"

/*: "orderNum" :*/
fileprivate let user_linkPendingFormat:[Character] = ["o","r","d","e","r","N","u","m"]

/*: "mf/recharge/applePayNotify" :*/
fileprivate let showInfoSoundString:[Character] = ["m","f","/","r","e"]
fileprivate let showSwitchePointPath:String = "chaglobalg"
fileprivate let confirmPlatformRefreshPath:String = "plePadevice m corner s"

/*: "reportMoney" :*/
fileprivate let formatterCornerError:String = "neverport"
fileprivate let dataReportSessionMessage:String = "fail accessMoney"

/*: "transactionId" :*/
fileprivate let data_pointEndURL:String = "transalevel"
fileprivate let factoryNameDict:String = "mic title mode loadtionId"

/*: "mf/AutoSub/AppleCreateOrder" :*/
fileprivate let notiOkFormat:String = "mf/Asuper view product"
fileprivate let constFilterMsg:String = "ub/Ainfo server presentation sub"
fileprivate let k_indexKey:String = "eeventte"
fileprivate let loggerTransactionMessage:String = "Orderin array indicator link"

/*: "orderId" :*/
fileprivate let showDoingId:[UInt8] = [0x64,0x49,0x72,0x65,0x64,0x72,0x6f]

/*: "mf/AutoSub/ApplePaySuccess" :*/
fileprivate let userReportKey:String = "mok"
fileprivate let modelOriginalPath:String = "create mirror/Aut"
fileprivate let managerWrittenValue:String = "content adjust normal minimum on/Apple"
fileprivate let parserNetworkDecideCount:String = "CESS"

/*: "App" :*/
fileprivate let userLevelDate:String = "as status origin launchApp"

/*: "OrderTransactionInfo_Cache" :*/
fileprivate let networkMediaGlobalId:String = "Orderobserver never load"
fileprivate let viewProductionTime:String = "ctcornern"
fileprivate let app_makeUrl:[Character] = ["I","n","f","o","_","C","a","c","h","e"]

/*: "OrderTransactionInfo_Subscribe_Cache" :*/
fileprivate let noti_viewEarthPath:[UInt8] = [0x75,0x98,0x8a,0x8b,0x98,0x7a,0x98,0x87,0x94,0x99,0x87,0x89,0x9a,0x8f,0x95,0x94,0x6f,0x94,0x8c,0x95,0x85,0x79,0x9b,0x88,0x99,0x89,0x98,0x8f,0x88,0x8b,0x85,0x69,0x87,0x89,0x8e,0x8b]

fileprivate func lensAdjustment(record num: UInt8) -> UInt8 {
    let value = Int(num) + 218
    if value > 255 {
        return UInt8(value - 256)
    } else {
        return UInt8(value)
    }
}

/*: "verifyData" :*/
fileprivate let userEnvironmentList:[UInt8] = [0x61,0x74,0x61,0x44,0x79,0x66,0x69,0x72,0x65,0x76]

/*: " 未知的交易类型" :*/
fileprivate let sessionPanelPath:[Character] = [""," ","未","知","\u{7684}","交","易","类","\u{578b}"]

//: Declare String End

//: import StoreKit
import StoreKit
// __DEBUG__
// __CLOSE_PRINT__
//: import UIKit
import UIKit

// 最大失败重试次数
//: let APPLE_IAP_MAX_RETRY_COUNT = 9
let sessionProductionPath = 9

/// 支付类型
//: enum ApplePayType {
enum DoingrushFlexible {
    //: case Pay
    case Pay // 支付
    //: case Subscribe
    case Subscribe // 订阅
}

/// 支付状态
//: enum AppleIAPStatus: String {
enum CrabappleArray: String {
    //: case unknow            = "未知类型"
    case unknow = "未知类型"
    //: case createOrderFail   = "创建订单失败"
    case createOrderFail = "创建订单失败"
    //: case notArrow          = "设备不允许"
    case notArrow = "设备不允许"
    //: case noProductId       = "缺少产品Id"
    case noProductId = "缺少产品Id"
    //: case failed            = "交易失败/取消"
    case failed = "交易失败/取消"
    //: case restored          = "已购买过该商品"
    case restored = "已购买过该商品"
    //: case deferred          = "交易延期"
    case deferred = "交易延期"
    //: case verityFail        = "服务器验证失败"
    case verityFail = "服务器验证失败"
    //: case veritySucceed     = "服务器验证成功"
    case veritySucceed = "服务器验证成功"
    //: case renewSucceed      = "自动续订成功"
    case renewSucceed = "自动续订成功"
}

//: typealias IAPcompletionHandle = (AppleIAPStatus, Double, ApplePayType) -> Void
typealias IAPcompletionHandle = (CrabappleArray, Double, DoingrushFlexible) -> Void

//: class AppleIAPManager: NSObject {
class SenateCampaignQuantityerval: NSObject {
    //: var completionHandle: IAPcompletionHandle?
    var completionHandle: IAPcompletionHandle?
    //: private var productInfoReq: SKProductsRequest?
    private var productInfoReq: SKProductsRequest?
    //: private var reqRetryCountDict = [String: Int]()
    private var reqRetryCountDict = [String: Int]() // 记录每个交易请求重试次数
    //: private var payCacheList = [[String: String]]()
    private var payCacheList = [[String: String]]() // 【购买】缓存数据
    //: private var subscribeCacheList = [[String: String]]()
    private var subscribeCacheList = [[String: String]]() // 【订阅】缓存数据
    //: private var createOrderId: String?
    private var createOrderId: String? // 当前支付服务端创建的订单id
    //: private var currentPayType: ApplePayType = .Pay
    private var currentPayType: DoingrushFlexible = .Pay // 当前支付类型

    // singleton
    //: static let shared = AppleIAPManager()
    static let shared = SenateCampaignQuantityerval()
    //: override func copy() -> Any { return self }
    override func copy() -> Any { return self }
    //: override func mutableCopy() -> Any { return self }
    override func mutableCopy() -> Any { return self }
    //: private override init() {
    override private init() {
        //: super.init()
        super.init()
        //: SKPaymentQueue.default().add(self as SKPaymentTransactionObserver)
        SKPaymentQueue.default().add(self as SKPaymentTransactionObserver)
        // 监听应用将要销毁
        //: NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate),
        NotificationCenter.default.addObserver(self, selector: #selector(executeDoing),
                                               //: name: UIApplication.willTerminateNotification,
                                               name: UIApplication.willTerminateNotification,
                                               //: object: nil)
                                               object: nil)
    }

    // MARK: - NotificationCenter

    //: @objc func appWillTerminate() {
    @objc func executeDoing() {
        //: SKPaymentQueue.default().remove(self as SKPaymentTransactionObserver)
        SKPaymentQueue.default().remove(self as SKPaymentTransactionObserver)
    }
}

// MARK: - 【苹果购买】业务接口

//: extension AppleIAPManager {
private extension SenateCampaignQuantityerval {
    /// 【购买】创建业务订单
    /// - Parameters:
    ///   - productId: 产品Id
    ///   - block: 回调
    //: fileprivate func req_pay_createAppleOrder(productId: String, source: Int, handle: @escaping (String?, Bool) -> Void) {
    func action(productId: String, source: Int, handle: @escaping (String?, Bool) -> Void) {
        //: let reqModel = AppRequestModel.init()
        let reqModel = MatchModel()
        //: reqModel.requestPath = "mf/recharge/createApplePay"
        reqModel.requestPath = (String(dataAddList) + String(formatterDecisionToken) + String(serviceAdjustmentStopData))
        //: var dict = Dictionary<String, Any>()
        var dict = [String: Any]()
        //: dict["productId"] = productId
        dict[(appReflexCameraKey.replacingOccurrences(of: "written", with: "r") + "uctI" + mainPoorKey.replacingOccurrences(of: "source", with: "d"))] = productId
        //: dict["source"] = source
        dict[(kUserOkKey.replacingOccurrences(of: "on", with: "s") + appLockupPresentationPath.replacingOccurrences(of: "run", with: "e"))] = source
        //: reqModel.params = dict
        reqModel.params = dict
        //: AppRequestTool.startPostRequest(model: reqModel) { succeed, result, errorModel in
        ReloadForeign.appear(model: reqModel) { succeed, result, errorModel in
            //: guard succeed == true else {
            guard succeed == true else {
                //: handle(nil, succeed)
                handle(nil, succeed)
                //: return
                return
            }

            //: var orderId: String?
            var orderId: String?
            //: let dict = result as? [String: Any]
            let dict = result as? [String: Any]
            //: if let value = dict?["orderNum"] as? String {
            if let value = dict?[(String(user_linkPendingFormat))] as? String {
                //: orderId = value
                orderId = value
            }
            //: handle(orderId, succeed)
            handle(orderId, succeed)
        }
    }

    /// 【购买】上传支付信息到服务器验证
    /// - Parameters:
    ///   - transaction: 交易信息
    ///   - params: 接口参数
    //: fileprivate func req_pay_uploadAppletransaction(_ transactionId: String, params: [String: String]) {
    func from(_ transactionId: String, params: [String: String]) {
        //: let reqModel = AppRequestModel.init()
        let reqModel = MatchModel()
        //: reqModel.requestPath = "mf/recharge/applePayNotify"
        reqModel.requestPath = (String(showInfoSoundString) + showSwitchePointPath.replacingOccurrences(of: "global", with: "r") + "e/ap" + String(confirmPlatformRefreshPath.prefix(5)) + "yNotify")
        //: reqModel.params = params
        reqModel.params = params
        //: AppRequestTool.startPostRequest(model: reqModel) { succeed, result, errorModel in
        ReloadForeign.appear(model: reqModel) { succeed, result, errorModel in
            //: guard succeed == true || errorModel?.errorCode == 405 else {
            guard succeed == true || errorModel?.errorCode == 405 else { // 验证接口失败，重试接口
                //: DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    //: self.transcationPurchasedToCheck(transactionId, .Pay)
                    self.center(transactionId, .Pay)
                }
                //: return
                return
            }

            //: let dict = result as? [String: Any]
            let dict = result as? [String: Any]
            //: let reportMoney: Double = {
            let reportMoney: Double = {
                //: if let d = dict?["reportMoney"] as? Double { return d }
                if let d = dict?[(formatterCornerError.replacingOccurrences(of: "never", with: "re") + String(dataReportSessionMessage.suffix(5)))] as? Double { return d }
                //: return 0
                return 0
                //: }()
            }()

            // 过滤已验证成功的订单数据
            //: let newPayCacheList = self.payCacheList.filter({$0["transactionId"] != transactionId})
            let newPayCacheList = self.payCacheList.filter { $0[(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6)))] != transactionId }
            //: let diskPath = self.getPayCachePath()
            let diskPath = self.acceptFor()
            //: NSKeyedArchiver.archiveRootObject(newPayCacheList, toFile: diskPath)
            NSKeyedArchiver.archiveRootObject(newPayCacheList, toFile: diskPath)

            // 成功回调
            //: self.completionHandle?(.veritySucceed, reportMoney, .Pay)
            self.completionHandle?(.veritySucceed, reportMoney, .Pay)
        }
    }
}

// MARK: - 【苹果订阅】业务接口

//: extension AppleIAPManager {
private extension SenateCampaignQuantityerval {
    /// 【订阅】创建业务订单
    /// - Parameters:
    ///   - productId: 产品Id
    ///   - block: 回调
    //: fileprivate func req_subscribe_createAppleOrder(productId: String, source: Int, handle: @escaping (String?, Bool) -> Void) {
    func lope(productId: String, source: Int, handle: @escaping (String?, Bool) -> Void) {
        //: let reqModel = AppRequestModel.init()
        let reqModel = MatchModel()
        //: reqModel.requestPath = "mf/AutoSub/AppleCreateOrder"
        reqModel.requestPath = (String(notiOkFormat.prefix(4)) + "utoS" + String(constFilterMsg.prefix(4)) + "ppleCr" + k_indexKey.replacingOccurrences(of: "event", with: "a") + String(loggerTransactionMessage.prefix(5)))
        //: var dict = Dictionary<String, Any>()
        var dict = [String: Any]()
        //: dict["productId"] = productId
        dict[(appReflexCameraKey.replacingOccurrences(of: "written", with: "r") + "uctI" + mainPoorKey.replacingOccurrences(of: "source", with: "d"))] = productId
        //: dict["source"] = source
        dict[(kUserOkKey.replacingOccurrences(of: "on", with: "s") + appLockupPresentationPath.replacingOccurrences(of: "run", with: "e"))] = source
        //: reqModel.params = dict
        reqModel.params = dict
        //: AppRequestTool.startPostRequest(model: reqModel) { succeed, result, errorModel in
        ReloadForeign.appear(model: reqModel) { succeed, result, errorModel in
            //: guard succeed == true else {
            guard succeed == true else {
                //: handle(nil, succeed)
                handle(nil, succeed)
                //: return
                return
            }

            //: var orderId: String? = nil
            var orderId: String?
            //: let dict = result as? [String: Any]
            let dict = result as? [String: Any]
            //: if let value = dict?["orderId"] as? String {
            if let value = dict?[String(bytes: showDoingId.reversed(), encoding: .utf8)!] as? String {
                //: orderId = value
                orderId = value
            }
            //: handle(orderId, succeed)
            handle(orderId, succeed)
        }
    }

    /// 【订阅】上传支付信息到服务器验证
    /// - Parameters:
    ///   - transaction: 交易信息
    ///   - params: 接口参数
    //: fileprivate func req_subscribe_uploadAppletransaction(_ transactionId: String, params: [String: String]) {
    func app(_ transactionId: String, params: [String: String]) {
        //: let reqModel = AppRequestModel.init()
        let reqModel = MatchModel()
        //: reqModel.requestPath = "mf/AutoSub/ApplePaySuccess"
        reqModel.requestPath = (userReportKey.replacingOccurrences(of: "ok", with: "f") + String(modelOriginalPath.suffix(4)) + "oSub" + String(managerWrittenValue.suffix(6)) + "PaySuc" + parserNetworkDecideCount.lowercased())
        //: reqModel.params = params
        reqModel.params = params
        //: AppRequestTool.startPostRequest(model: reqModel) { succeed, result, errorModel in
        ReloadForeign.appear(model: reqModel) { succeed, result, errorModel in
            //: guard succeed == true || errorModel?.errorCode == 405 else {
            guard succeed == true || errorModel?.errorCode == 405 else { // 验证接口失败，重试接口
                //: DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    //: self.transcationPurchasedToCheck(transactionId, .Subscribe)
                    self.center(transactionId, .Subscribe)
                }
                //: return
                return
            }

            //: let dict = result as? [String: Any]
            let dict = result as? [String: Any]
            //: let reportMoney: Double = {
            let reportMoney: Double = {
                //: if let d = dict?["reportMoney"] as? Double { return d }
                if let d = dict?[(formatterCornerError.replacingOccurrences(of: "never", with: "re") + String(dataReportSessionMessage.suffix(5)))] as? Double { return d }
                //: return 0
                return 0
                //: }()
            }()

            // 过滤已验证成功的订单数据
            //: let newSubscribeCacheList = self.subscribeCacheList.filter({$0["transactionId"] != transactionId})
            let newSubscribeCacheList = self.subscribeCacheList.filter { $0[(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6)))] != transactionId }
            //: let diskPath = self.getSubscribeCachePath()
            let diskPath = self.mediaClear()
            //: NSKeyedArchiver.archiveRootObject(newSubscribeCacheList, toFile: diskPath)
            NSKeyedArchiver.archiveRootObject(newSubscribeCacheList, toFile: diskPath)

            // 成功回调
            //: self.completionHandle?(.veritySucceed, reportMoney, .Subscribe)
            self.completionHandle?(.veritySucceed, reportMoney, .Subscribe)
        }
    }
}

// MARK: - Event

//: extension AppleIAPManager {
extension SenateCampaignQuantityerval {
    /// 初始化数据
    //: private func iap_initData() {
    private func create() {
        //: self.payCacheList = getLocalPayCacheList(payType: .Pay)
        self.payCacheList = pastName(payType: .Pay)
        //: self.subscribeCacheList = getLocalPayCacheList(payType: .Subscribe)
        self.subscribeCacheList = pastName(payType: .Subscribe)
        //: self.createOrderId = nil
        self.createOrderId = nil
    }

    /// 获取缓存列表
    /// - Parameter payType: 支付类型
    /// - Returns: 缓存列表
    //: private func getLocalPayCacheList(payType: ApplePayType) -> [[String: String]] {
    private func pastName(payType: DoingrushFlexible) -> [[String: String]] {
        //: var list: [[String: String]]?
        var list: [[String: String]]?
        //: var diskPath = ""
        var diskPath = ""
        //: if payType == .Pay {
        if payType == .Pay {
            //: diskPath = getPayCachePath()
            diskPath = acceptFor()
            //: } else {
        } else {
            //: diskPath = getSubscribeCachePath()
            diskPath = mediaClear()
        }

        //: if FileManager.default.fileExists(atPath: diskPath) {
        if FileManager.default.fileExists(atPath: diskPath) {
            //: list = NSKeyedUnarchiver.unarchiveObject(withFile: diskPath) as? [[String: String]]
            list = NSKeyedUnarchiver.unarchiveObject(withFile: diskPath) as? [[String: String]]
            //: if list == nil {
            if list == nil {
                //: try? FileManager.default.removeItem(atPath: diskPath)
                try? FileManager.default.removeItem(atPath: diskPath)
            }
        }
        //: if list == nil {
        if list == nil {
            //: list = [[String: String]]()
            list = [[String: String]]()
        }
        //: return list!
        return list!
    }

    /// 获取【购买】缓存路径【和uid关联】
    /// - Returns: 缓存路径
    //: private func getPayCachePath() -> String {
    private func acceptFor() -> String {
        //: let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        //: let appDirectoryPath = (documentDirectoryPath as NSString).appendingPathComponent("App")
        let appDirectoryPath = (documentDirectoryPath as NSString).appendingPathComponent((String(userLevelDate.suffix(3))))

        //: let fileManager = FileManager.default
        let fileManager = FileManager.default
        //: if fileManager.fileExists(atPath: appDirectoryPath) == false {
        if fileManager.fileExists(atPath: appDirectoryPath) == false {
            //: try? fileManager.createDirectory(atPath: appDirectoryPath, withIntermediateDirectories: true)
            try? fileManager.createDirectory(atPath: appDirectoryPath, withIntermediateDirectories: true)
        }

        //: let filePath = (appDirectoryPath as NSString).appendingPathComponent("OrderTransactionInfo_Cache")
        let filePath = (appDirectoryPath as NSString).appendingPathComponent((String(networkMediaGlobalId.prefix(5)) + "Transa" + viewProductionTime.replacingOccurrences(of: "corner", with: "io") + String(app_makeUrl)))
        //: return filePath
        return filePath
    }

    /// 获取【订阅】缓存路径【和uid关联】
    /// - Returns: 缓存路径
    //: private func getSubscribeCachePath() -> String {
    private func mediaClear() -> String {
        //: let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        //: let appDirectoryPath = (documentDirectoryPath as NSString).appendingPathComponent("App")
        let appDirectoryPath = (documentDirectoryPath as NSString).appendingPathComponent((String(userLevelDate.suffix(3))))

        //: let fileManager = FileManager.default
        let fileManager = FileManager.default
        //: if fileManager.fileExists(atPath: appDirectoryPath) == false {
        if fileManager.fileExists(atPath: appDirectoryPath) == false {
            //: try? fileManager.createDirectory(atPath: appDirectoryPath, withIntermediateDirectories: true)
            try? fileManager.createDirectory(atPath: appDirectoryPath, withIntermediateDirectories: true)
        }

        //: let filePath = (appDirectoryPath as NSString).appendingPathComponent("OrderTransactionInfo_Subscribe_Cache")
        let filePath = (appDirectoryPath as NSString).appendingPathComponent(String(bytes: noti_viewEarthPath.map{lensAdjustment(record: $0)}, encoding: .utf8)!)
        //: return filePath
        return filePath
    }

    /// 获取本地收据数据
    /// - Parameters:
    ///   - transactionId: 收据标识符
    ///   - payType: 支付类型
    /// - Returns: 收据数据
    //: fileprivate func getVerifyData(_ transactionId: String, _ payType: ApplePayType) -> String? {
    fileprivate func byGainAssemblage(_ transactionId: String, _ payType: DoingrushFlexible) -> String? {
        // 有未完成的订单，先取缓存
        //: var paramsArr = [[String: String]]()
        var paramsArr = [[String: String]]()
        //: switch(payType) {
        switch payType {
        //: case .Pay:
        case .Pay:
            //: paramsArr = self.payCacheList.filter({$0["transactionId"] == transactionId})
            paramsArr = self.payCacheList.filter { $0[(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6)))] == transactionId }
        //: case .Subscribe:
        case .Subscribe:
            //: paramsArr = self.subscribeCacheList.filter({$0["transactionId"] == transactionId})
            paramsArr = self.subscribeCacheList.filter { $0[(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6)))] == transactionId }
        }
        //: if paramsArr.count > 0 && paramsArr.first!["verifyData"] != nil {
        if paramsArr.count > 0, paramsArr.first![String(bytes: userEnvironmentList.reversed(), encoding: .utf8)!] != nil {
            //: return paramsArr.first!["verifyData"]
            return paramsArr.first![String(bytes: userEnvironmentList.reversed(), encoding: .utf8)!]
        }

        // 取本地
        //: guard let receiptUrl = Bundle.main.appStoreReceiptURL else { return nil }
        guard let receiptUrl = Bundle.main.appStoreReceiptURL else { return nil }
        //: let data = NSData(contentsOf: receiptUrl)
        let data = NSData(contentsOf: receiptUrl)
        //: let receiptStr = data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let receiptStr = data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        //: return receiptStr
        return receiptStr
    }
}

// MARK: - 失败重试流程

//: extension AppleIAPManager {
extension SenateCampaignQuantityerval {
    /// 检测未完成的苹果支付【只会重试当前登录用户】
    //: func iap_checkUnfinishedTransactions() {
    func head() {
        //: iap_initData()
        create()

        // 【购买】失败重试
        //: for dict in self.payCacheList {
        for dict in self.payCacheList {
            //: iap_failedRetry(dict["transactionId"], .Pay)
            indicator(dict[(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6)))], .Pay)
        }

        // 【订阅】失败重试
        //: for dict in self.subscribeCacheList {
        for dict in self.subscribeCacheList {
            //: iap_failedRetry(dict["transactionId"], .Subscribe)
            indicator(dict[(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6)))], .Subscribe)
        }
    }

    /// 失败重试
    /// - Parameters:
    ///   - transactionId: Id
    ///   - payType: 支付类型
    //: private func iap_failedRetry(_ transactionId: String?, _ payType: ApplePayType) {
    private func indicator(_ transactionId: String?, _ payType: DoingrushFlexible) {
        //: guard let transactionId = transactionId else { return }
        guard let transactionId = transactionId else { return }
        // 初始化每个交易请求次数
        //: reqRetryCountDict[transactionId] = 0
        reqRetryCountDict[transactionId] = 0
        // 3. 服务端校验流程
        //: transcationPurchasedToCheck(transactionId, payType)
        center(transactionId, payType)
    }
}

// MARK: - 苹果正常支付流程

//: extension AppleIAPManager {
extension SenateCampaignQuantityerval {
    /// 发起苹果支付【1.创建订单； 2.发起苹果支付； 3.服务端校验】
    /// - Parameters:
    ///   - purchID: 产品ID
    ///   - payType: 支付类型
    ///   - handle: 回调
    ///   - source: 0 常规充值 1 观看视频后充值或订阅
    //: func iap_startPurchase(productId: String, payType: ApplePayType, source: Int = 0, handle: @escaping IAPcompletionHandle) {
    func run(productId: String, payType: DoingrushFlexible, source: Int = 0, handle: @escaping IAPcompletionHandle) {
        //: iap_initData()
        create()
        //: self.completionHandle = handle
        self.completionHandle = handle
        //: self.currentPayType = payType
        self.currentPayType = payType

        // 1. 根据类型创建订单
        //: switch(payType) {
        switch payType {
        //: case .Pay:
        case .Pay:
            //: req_pay_createAppleOrder(productId: productId, source: source) { [weak self] orderId, succeed in
            action(productId: productId, source: source) { [weak self] orderId, succeed in
                //: guard let self = self else { return }
                guard let self = self else { return }
                //: guard succeed == true && orderId != nil else {
                guard succeed == true && orderId != nil else { // 订单创建失败
                    //: self.completionHandle?(.createOrderFail, 0, .Pay)
                    self.completionHandle?(.createOrderFail, 0, .Pay)
                    //: return
                    return
                }

                //: self.createOrderId = orderId
                self.createOrderId = orderId
                //: self.requestProductInfo(productId)
                self.executeApp(productId)
            }

        //: case .Subscribe:
        case .Subscribe:
            //: req_subscribe_createAppleOrder(productId: productId, source: source) { [weak self] orderId, succeed in
            lope(productId: productId, source: source) { [weak self] orderId, succeed in
                //: guard let self = self else { return }
                guard let self = self else { return }
                //: guard succeed == true && orderId != nil else {
                guard succeed == true && orderId != nil else { // 订单创建失败
                    //: self.completionHandle?(.createOrderFail, 0, .Subscribe)
                    self.completionHandle?(.createOrderFail, 0, .Subscribe)
                    //: return
                    return
                }

                //: self.createOrderId = orderId
                self.createOrderId = orderId
                //: self.requestProductInfo(productId)
                self.executeApp(productId)
            }
        }
    }

    // 2 发起苹果支付，查询apple内购商品
    //: fileprivate func requestProductInfo(_ productId: String) {
    fileprivate func executeApp(_ productId: String) {
        //: guard SKPaymentQueue.canMakePayments() else {
        guard SKPaymentQueue.canMakePayments() else {
            //: self.completionHandle?(.notArrow, 0, currentPayType)
            self.completionHandle?(.notArrow, 0, currentPayType)
            //: return
            return
        }

        // 销毁当前请求
        //: self.clearProductInfoRequest()
        self.pellucid()
        // 查询apple内购商品
        //: let identifiers: Set<String> = [productId]
        let identifiers: Set<String> = [productId]
        //: productInfoReq = SKProductsRequest(productIdentifiers: identifiers)
        productInfoReq = SKProductsRequest(productIdentifiers: identifiers)
        //: productInfoReq?.delegate = self
        productInfoReq?.delegate = self
        //: productInfoReq?.start()
        productInfoReq?.start()
    }

    // 销毁当前请求
    //: fileprivate func clearProductInfoRequest() {
    fileprivate func pellucid() {
        //: guard productInfoReq != nil else { return }
        guard productInfoReq != nil else { return }
        //: productInfoReq?.delegate = nil
        productInfoReq?.delegate = nil
        //: productInfoReq?.cancel()
        productInfoReq?.cancel()
        //: productInfoReq = nil
        productInfoReq = nil
    }
}

// MARK: - SKProductsRequestDelegate【商品查询】

//: extension AppleIAPManager: SKProductsRequestDelegate {
extension SenateCampaignQuantityerval: SKProductsRequestDelegate {
    // 查询apple内购商品成功回调
    //: func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        //: guard response.products.count > 0 else {
        guard response.products.count > 0 else {
            //: self.completionHandle?( .noProductId, 0, currentPayType)
            self.completionHandle?(.noProductId, 0, currentPayType)
            //: return
            return
        }

        //: let payment = SKPayment(product: response.products.first!)
        let payment = SKPayment(product: response.products.first!)
        //: SKPaymentQueue.default().add(payment)
        SKPaymentQueue.default().add(payment)
    }

    // 查询apple内购商品失败
    //: func request(_ request: SKRequest, didFailWithError error: Error) {
    func request(_ request: SKRequest, didFailWithError error: Error) {
        //: self.completionHandle?( .noProductId, 0, currentPayType)
        self.completionHandle?(.noProductId, 0, currentPayType)
    }

    // 查询apple内购商品完成
    //: func requestDidFinish(_ request: SKRequest) {
    func requestDidFinish(_ request: SKRequest) {}
}

// MARK: - SKPaymentTransactionObserver【支付回调】

//: extension AppleIAPManager: SKPaymentTransactionObserver {
extension SenateCampaignQuantityerval: SKPaymentTransactionObserver {
    /// 2.2 apple内购完成回调
    //: func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //: for transaction in transactions {
        for transaction in transactions {
            //: switch transaction.transactionState {
            switch transaction.transactionState {
            //: case .purchasing:
            case .purchasing: // 交易中
                //: break
                break

            //: case .purchased:
            case .purchased: // 交易成功
                /**
                 original.transactionIdentifier 首次订阅时为nil，transaction.transactionIdentifier有值；
                 后续自动订阅、续订时，original.transactionIdentifier为首次订阅时生成的transaction.transactionIdentifier，值固定不变；
                 每次订阅transaction.transactionIdentifier都不一样，为当前交易的标识；
                 */
                //: if transaction.original != nil && createOrderId == nil {
                if transaction.original != nil && createOrderId == nil { // 启动自动续订时，不需要调用服务端验证接口
                    //: self.completionHandle?(.renewSucceed, 0, currentPayType)
                    self.completionHandle?(.renewSucceed, 0, currentPayType)
                    //: } else {
                } else { // 普通购买和订阅
                    // 初始化每个交易请求次数
                    //: reqRetryCountDict[transaction.transactionIdentifier!] = 0
                    reqRetryCountDict[transaction.transactionIdentifier!] = 0
                    // 3. 服务端校验流程
                    //: transcationPurchasedToCheck(transaction.transactionIdentifier!, self.currentPayType)
                    center(transaction.transactionIdentifier!, self.currentPayType)
                }
                // 移除苹果支付系统缓存
                //: SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                //: createOrderId = nil
                createOrderId = nil

            //: case .failed:
            case .failed: // 交易失败/取消
                //: SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                //: self.completionHandle?(.failed, 0, currentPayType)
                self.completionHandle?(.failed, 0, currentPayType)
                //: createOrderId = nil
                createOrderId = nil

            //: case .restored:
            case .restored: // 已购买过该商品
                //: SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                //: self.completionHandle?(.restored, 0, currentPayType)
                self.completionHandle?(.restored, 0, currentPayType)
                //: createOrderId = nil
                createOrderId = nil

            //: case .deferred:
            case .deferred: // 交易延期
                //: SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                //: self.completionHandle?(.deferred, 0, currentPayType)
                self.completionHandle?(.deferred, 0, currentPayType)
                //: createOrderId = nil
                createOrderId = nil

            //: @unknown default:
            @unknown default:
                //: SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                //: self.completionHandle?(.unknow, 0, currentPayType)
                self.completionHandle?(.unknow, 0, currentPayType)
                //: createOrderId = nil
                createOrderId = nil
                //: fatalError(" 未知的交易类型")
                fatalError((String(sessionPanelPath)))
            }
        }
    }

    /// 3. 服务端校验流程
    /// - Parameters:
    ///   - transactionId: 交易唯一标识符
    ///   - payType: 支付类型
    //: fileprivate func transcationPurchasedToCheck(_ transactionId: String, _ payType: ApplePayType) {
    fileprivate func center(_ transactionId: String, _ payType: DoingrushFlexible) {
        //: guard let receiptStr = getVerifyData(transactionId, payType) else {
        guard let receiptStr = byGainAssemblage(transactionId, payType) else {
            //: self.completionHandle?(.verityFail, 0, payType)
            self.completionHandle?(.verityFail, 0, payType)
            //: return
            return
        }

        // 缓存支付成功信息，防止接口校验失败
        //: if createOrderId != nil {
        if createOrderId != nil { // 正常支付流程
            //: switch(payType) {
            switch payType {
            //: case .Pay:
            case .Pay:
                //: if self.payCacheList.filter({$0["transactionId"] == transactionId || $0["orderId"] == createOrderId}).count == 0 {  // 防止重复添加缓存数据
                if self.payCacheList.filter({ $0[(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6)))] == transactionId || $0[String(bytes: showDoingId.reversed(), encoding: .utf8)!] == createOrderId }).count == 0 { // 防止重复添加缓存数据
                    //: let cacheDict = ["transactionId": transactionId,
                    let cacheDict = [(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6))): transactionId,
                                     //: "orderId": createOrderId!,
                                     String(bytes: showDoingId.reversed(), encoding: .utf8)!: createOrderId!,
                                     //: "verifyData": receiptStr]
                                     String(bytes: userEnvironmentList.reversed(), encoding: .utf8)!: receiptStr]
                    //: self.payCacheList.append(cacheDict)
                    self.payCacheList.append(cacheDict)
                    //: let diskPath = self.getPayCachePath()
                    let diskPath = self.acceptFor()
                    //: NSKeyedArchiver.archiveRootObject(self.payCacheList, toFile: diskPath)
                    NSKeyedArchiver.archiveRootObject(self.payCacheList, toFile: diskPath)
                }

            //: case .Subscribe:
            case .Subscribe:
                //: if self.subscribeCacheList.filter({$0["transactionId"] == transactionId || $0["orderId"] == createOrderId}).count == 0 { // 防止重复添加缓存数据
                if self.subscribeCacheList.filter({ $0[(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6)))] == transactionId || $0[String(bytes: showDoingId.reversed(), encoding: .utf8)!] == createOrderId }).count == 0 { // 防止重复添加缓存数据
                    //: let cacheDict = ["transactionId": transactionId,
                    let cacheDict = [(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6))): transactionId,
                                     //: "orderId": createOrderId!,
                                     String(bytes: showDoingId.reversed(), encoding: .utf8)!: createOrderId!,
                                     //: "verifyData": receiptStr]
                                     String(bytes: userEnvironmentList.reversed(), encoding: .utf8)!: receiptStr]
                    //: self.subscribeCacheList.append(cacheDict)
                    self.subscribeCacheList.append(cacheDict)
                    //: let diskPath = self.getSubscribeCachePath()
                    let diskPath = self.mediaClear()
                    //: NSKeyedArchiver.archiveRootObject(self.subscribeCacheList, toFile: diskPath)
                    NSKeyedArchiver.archiveRootObject(self.subscribeCacheList, toFile: diskPath)
                }
            }
        }

        // 限制交易重试最大次数
        //: var reqCount = reqRetryCountDict[transactionId] ?? 0
        var reqCount = reqRetryCountDict[transactionId] ?? 0
        //: reqCount += 1
        reqCount += 1
        //: reqRetryCountDict[transactionId] = reqCount
        reqRetryCountDict[transactionId] = reqCount
        //: if reqCount > APPLE_IAP_MAX_RETRY_COUNT {
        if reqCount > sessionProductionPath {
            //: self.completionHandle?(.verityFail, 0, payType)
            self.completionHandle?(.verityFail, 0, payType)
            //: return
            return
        }

        // 3.服务端校验，根据transactionId从缓存中取
        //: switch(payType) {
        switch payType {
        //: case .Pay:
        case .Pay:
            //: let paramsArr = self.payCacheList.filter({$0["transactionId"] == transactionId})
            let paramsArr = self.payCacheList.filter { $0[(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6)))] == transactionId }
            //: guard paramsArr.count > 0 else { return }
            guard paramsArr.count > 0 else { return }
            //: req_pay_uploadAppletransaction(transactionId, params: paramsArr.first!)
            from(transactionId, params: paramsArr.first!)

        //: case .Subscribe:
        case .Subscribe:
            //: let paramsArr = self.subscribeCacheList.filter({$0["transactionId"] == transactionId})
            let paramsArr = self.subscribeCacheList.filter { $0[(data_pointEndURL.replacingOccurrences(of: "level", with: "c") + String(factoryNameDict.suffix(6)))] == transactionId }
            //: guard paramsArr.count > 0 else { return }
            guard paramsArr.count > 0 else { return }
            //: req_subscribe_uploadAppletransaction(transactionId, params: paramsArr.first!)
            app(transactionId, params: paramsArr.first!)
        }
    }
}
