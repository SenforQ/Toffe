
//: Declare String Begin

/*: "LaunchImage" :*/
fileprivate let sessionContactBackMessage:String = "Launadjust add"
fileprivate let networkFoundationStr:String = "chImagedo add on false will"

//: Declare String End

// __DEBUG__
// __CLOSE_PRINT__
//
//  BasicOkViewController.swift
//  OverseaH5
//
//  Created by DouXiu on 2025/11/27.
//

//: import UIKit
import UIKit

//: class WaitViewController: UIViewController {
class BasicOkViewController: UIViewController {
    //: override func viewDidLoad() {
    override func viewDidLoad() {
        //: super.viewDidLoad()
        super.viewDidLoad()
        //: let bgImgV = UIImageView()
        let bgImgV = UIImageView()
        //: bgImgV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        bgImgV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //: bgImgV.image = UIImage(named: "LaunchImage")
        bgImgV.image = UIImage(named: (String(sessionContactBackMessage.prefix(4)) + String(networkFoundationStr.prefix(7))))
        //: view.addSubview(bgImgV)
        view.addSubview(bgImgV)
    }
}
