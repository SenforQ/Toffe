
//: Declare String Begin

/*: "Net Error, Try again later" :*/
fileprivate let factoryUserState:[Character] = ["N","e","t"," "]
fileprivate let k_backgroundKey:[Character] = ["E","r","r","o","r",","," ","T","r","y"," ","a","g","a","i","n"," ","l","a","t","e","r"]

/*: "data" :*/
fileprivate let notiEveryLastStr:String = "dpasttpast"

/*: ":null" :*/
fileprivate let managerCorePathDict:[Character] = [":","n","u","l","l"]

/*: "json error" :*/
fileprivate let const_sourceDate:String = "level class grade newjson e"

/*: "platform=iphone&version= :*/
fileprivate let k_managerBarList:String = "indexl"
fileprivate let viewIndicatorElementPath:String = "atfoblock"
fileprivate let controllerExhibitToken:String = "success secret goone&"
fileprivate let factoryStopError:String = "ion=scale class"

/*: &packageId= :*/
fileprivate let kSubDisplaySecret:[Character] = ["&","p","a","c","k","a","g","e","I","d","="]

/*: &bundleId= :*/
fileprivate let modelSelectedList:String = "tab"
fileprivate let mainEnableMessage:[Character] = ["b","u","n","d","l","e","I","d","="]

/*: &lang= :*/
fileprivate let main_gatheringCountrySecret:[Character] = ["&","l","a","n","g","="]

/*: ; build: :*/
fileprivate let serviceChallengeMirrorFormat:String = "; buildsearch restaurant"
fileprivate let serviceOriginalMsg:[Character] = [":"]

/*: ; iOS  :*/
fileprivate let notiFactoryTime:[Character] = [";"," ","i","O","S"," "]

//: Declare String End

//: import Alamofire
import Alamofire
//: import CoreMedia
import CoreMedia
//: import HandyJSON
import HandyJSON
// __DEBUG__
// __CLOSE_PRINT__
//: import UIKit
import UIKit

//: typealias FinishBlock = (_ succeed: Bool, _ result: Any?, _ errorModel: AppErrorResponse?) -> Void
typealias FinishBlock = (_ succeed: Bool, _ result: Any?, _ errorModel: AvailableEqualFatal?) -> Void

//: @objc class AppRequestTool: NSObject {
@objc class ReloadForeign: NSObject {
    /// 发起Post请求
    /// - Parameters:
    ///   - model: 请求参数
    ///   - completion: 回调
    //: class func startPostRequest(model: AppRequestModel, completion: @escaping FinishBlock) {
    class func appear(model: MatchModel, completion: @escaping FinishBlock) {
        //: let serverUrl = self.buildServerUrl(model: model)
        let serverUrl = self.cantileverBy(model: model)
        //: let headers = self.getRequestHeader(model: model)
        let headers = self.substance(model: model)
        //: AF.request(serverUrl, method: .post, parameters: model.params, headers: headers, requestModifier: { $0.timeoutInterval = 10.0 }).responseData { [self] responseData in
        AF.request(serverUrl, method: .post, parameters: model.params, headers: headers, requestModifier: { $0.timeoutInterval = 10.0 }).responseData { [self] responseData in
            //: switch responseData.result {
            switch responseData.result {
            //: case .success:
            case .success:
                //: func__requestSucess(model: model, response: responseData.response!, responseData: responseData.data!, completion: completion)
                view(model: model, response: responseData.response!, responseData: responseData.data!, completion: completion)

            //: case .failure:
            case .failure:
                //: completion(false, nil, AppErrorResponse.init(errorCode: RequestResultCode.NetError.rawValue, errorMsg: "Net Error, Try again later"))
                completion(false, nil, AvailableEqualFatal(errorCode: SlidingWindowNotice.NetError.rawValue, errorMsg: (String(factoryUserState) + String(k_backgroundKey))))
            }
        }
    }

    //: class func func__requestSucess(model: AppRequestModel, response: HTTPURLResponse, responseData: Data, completion: @escaping FinishBlock) {
    class func view(model: MatchModel, response: HTTPURLResponse, responseData: Data, completion: @escaping FinishBlock) {
        //: var responseJson = String(data: responseData, encoding: .utf8)
        var responseJson = String(data: responseData, encoding: .utf8)
        //: responseJson = responseJson?.replacingOccurrences(of: "\"data\":null", with: "\"data\":{}")
        responseJson = responseJson?.replacingOccurrences(of: "\"" + (notiEveryLastStr.replacingOccurrences(of: "past", with: "a")) + "\"" + (String(managerCorePathDict)), with: "" + "\"" + (notiEveryLastStr.replacingOccurrences(of: "past", with: "a")) + "\"" + ":{}")
        //: if let responseModel = JSONDeserializer<AppBaseResponse>.deserializeFrom(json: responseJson) {
        if let responseModel = JSONDeserializer<BasicPathEvaluate>.deserializeFrom(json: responseJson) {
            //: if responseModel.errno == RequestResultCode.Normal.rawValue {
            if responseModel.errno == SlidingWindowNotice.Normal.rawValue {
                //: completion(true, responseModel.data, nil)
                completion(true, responseModel.data, nil)
                //: } else {
            } else {
                //: completion(false, responseModel.data, AppErrorResponse.init(errorCode: responseModel.errno, errorMsg: responseModel.msg ?? ""))
                completion(false, responseModel.data, AvailableEqualFatal(errorCode: responseModel.errno, errorMsg: responseModel.msg ?? ""))
                //: switch responseModel.errno {
                switch responseModel.errno {
//                case SlidingWindowNotice.NeedReLogin.rawValue:
//                    NotificationCenter.default.post(name: DID_LOGIN_OUT_SUCCESS_NOTIFICATION, object: nil, userInfo: nil)
                //: default:
                default:
                    //: break
                    break
                }
            }
            //: } else {
        } else {
            //: completion(false, nil, AppErrorResponse.init(errorCode: RequestResultCode.NetError.rawValue, errorMsg: "json error"))
            completion(false, nil, AvailableEqualFatal(errorCode: SlidingWindowNotice.NetError.rawValue, errorMsg: (String(const_sourceDate.suffix(6)) + "rror")))
        }
    }

    //: class func buildServerUrl(model: AppRequestModel) -> String {
    class func cantileverBy(model: MatchModel) -> String {
        //: var serverUrl: String = model.requestServer
        var serverUrl: String = model.requestServer
        //: let otherParams = "platform=iphone&version=\(AppNetVersion)&packageId=\(PackageID)&bundleId=\(AppBundle)&lang=\(UIDevice.interfaceLang)"
        let otherParams = (k_managerBarList.replacingOccurrences(of: "index", with: "p") + viewIndicatorElementPath.replacingOccurrences(of: "block", with: "rm") + "=iph" + String(controllerExhibitToken.suffix(4)) + "vers" + String(factoryStopError.prefix(4))) + "\(sessionLevelDate)" + (String(kSubDisplaySecret)) + "\(cacheWarnMessage)" + (modelSelectedList.replacingOccurrences(of: "tab", with: "&") + String(mainEnableMessage)) + "\(helperOpticalLensKey)" + (String(main_gatheringCountrySecret)) + "\(UIDevice.interfaceLang)"
        //: if !model.requestPath.isEmpty {
        if !model.requestPath.isEmpty {
            //: serverUrl.append("/\(model.requestPath)")
            serverUrl.append("/\(model.requestPath)")
        }
        //: serverUrl.append("?\(otherParams)")
        serverUrl.append("?\(otherParams)")

        //: return serverUrl
        return serverUrl
    }

    /// 获取请求头参数
    /// - Parameter model: 请求模型
    /// - Returns: 请求头参数
    //: class func getRequestHeader(model: AppRequestModel) -> HTTPHeaders {
    class func substance(model: MatchModel) -> HTTPHeaders {
        //: let userAgent = "\(AppName)/\(AppVersion) (\(AppBundle); build:\(AppBuildNumber); iOS \(UIDevice.current.systemVersion); \(UIDevice.modelName))"
        let userAgent = "\(show_saveString)/\(progressEmptyId) (\(helperOpticalLensKey)" + (String(serviceChallengeMirrorFormat.prefix(7)) + String(serviceOriginalMsg)) + "\(data_appMode)" + (String(notiFactoryTime)) + "\(UIDevice.current.systemVersion); \(UIDevice.modelName))"
        //: let headers = [HTTPHeader.userAgent(userAgent)]
        let headers = [HTTPHeader.userAgent(userAgent)]
        //: return HTTPHeaders(headers)
        return HTTPHeaders(headers)
    }
}
