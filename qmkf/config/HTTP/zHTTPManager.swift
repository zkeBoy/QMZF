//
//  zHTTPManager.swift
//  qmkf
//
//  Created by Mac on 2020/2/21.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import Alamofire

let BASE_URL = "http://29206c181r.wicp.vip:34207/v1/api/"

let headers: HTTPHeaders = [
    "Content-Type": "application/json",
    "Authorization": token as! String
]

func testHttp() {
    let parameters : ZParameters = [
        "account": "zzz",
        "code": "string",
        "password": "111",
        "phone": "17713605496",
        "simplify": "test_template"
    ]
    let url = BASE_URL + "user/register"
//    post(url,parameters: parameters) {(result) in
//        print(result)
//    }
}

func getCode_pub(_ phone:String) {

    let parameters : ZParameters = [
        "phone": phone ,
        "simplify": "test_template"
        ]
    post("cms-sms-template/sendSms", parameters: parameters, true, true) {(result) in
        print(result)
    }
}

func post(_ url:String,parameters:[String : Any]? = nil, _ showToastActivity : Bool , _ showToast : Bool, finishedCallback: @escaping (_ result : Any)->()) {
    let url = BASE_URL + url
    
    if showToastActivity {
        getCurrentWindow()?.makeToastActivity(NSValue.init(cgPoint: getCurrentWindow()!.center))
    }
    
    Alamofire.request(url,method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
        (response) in
        
        getCurrentWindow()?.hideToastActivity()
        
        switch response.result{
        case .success(let json):
            if (ZJSON(json)["code"].int == 200) {
                finishedCallback(response.result.value as Any)
               
                if showToast { 
                    if ZJSON(json)["data"]["records"].exists() && ZJSON(json)["data"]["records"].count == 0 {
                                       getCurrentWindow()?.makeToast("   无数据   ", duration: 0.6, position: NSValue.init(cgPoint: getCurrentWindow()!.center))
                    } else {
                        getCurrentWindow()?.makeToast("    成功    ", duration: 0.6, position: NSValue.init(cgPoint: getCurrentWindow()!.center))
                    }
                }
            } else {
                getCurrentWindow()?.makeToast("   \(ZJSON(json)["message"])   ", duration: 0.6, position: NSValue.init(cgPoint: getCurrentWindow()!.center))
            }
            break
        case .failure:
            getCurrentWindow()?.makeToast("   连接服务器失败   ", duration: 0.6, position: NSValue.init(cgPoint: getCurrentWindow()!.center))
            break
        }
//        case .success(let json):
//        case .failure(let error):
    }
}
