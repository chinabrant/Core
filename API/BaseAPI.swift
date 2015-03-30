//
//  BaseAPI.swift
//  Tianmijie
//
//  Created by Brant on 12/26/14.
//  Copyright (c) 2014 tianmitech. All rights reserved.
//

import Foundation

enum RequestType {
    case None
    case Login
    case VerifyPhone
    case VerifyCode
    case Register
    case ChangePwd
    case ModifyUserinfo
    case UploadAvatar
    case UserInfo
    case Feedback
    case Aboutus
    
    case AreaList       // 商圈列表
    
    case StoreList  // 商家列表
    case StoreCateList  // 
    case StoreDetail    // 门店详情
    case StorageDetail  // 自提点详情
    
    case CurrentStorage     // 根据位置点取提餐点
    case HomeIndex          // 主页面的商品列表
    
    case AddTopic           // 添加晒早
    
    case OurGoodsDetail // 
}

protocol BaseAPIDelegate {
    func didFinishRequest(result: JSON, errorCode: Int, errorDesc: String, requestType: RequestType)
    func didFailRequest(result: JSON, errorCode: Int, message: String, requestType: RequestType)
    func didFailWithNetworkError(error: NSError, requestType: RequestType)
}

public class BaseAPI {

    var http: HTTPTask = HTTPTask()
    var delegate: BaseAPIDelegate?
    var requestType: RequestType = RequestType.None
    var isRequesting = false
    
    // 正式环境参数 http://api.tianmijie.com    http://apiv14.tianmijie.com
    let BaseUrl = "http://121.40.135.60:8081/mapi/index.php?"
    // let BaseUrl = "http://apiv14.tianmijie.com"
    
    init() {
        http.baseURL = BaseUrl
    }
    
    
    // 下午两点半，好困，洗了把冷水脸 
    func get(action: String, parameters: Dictionary<String,AnyObject>?) {
        var pars: Dictionary<String, AnyObject> = ["r_type": "1"]
        if parameters != nil {
            pars = parameters!
            pars.updateValue("1", forKey: "r_type")
        }

        self.isRequesting = true
        
        println("开始请求")
        http.GET(action, parameters: pars, success: { (response) -> Void in
            println("BaseAPI: url:\(response.URL) \n response: \(response.responseObject)")
            self.isRequesting = false
            
            // 成功
            if response.responseObject != nil {
                
                var result = JSON(data: response.responseObject as NSData, options: NSJSONReadingOptions.MutableLeaves, error: nil)
                println("data: \(result)")
                
                if result["return"].int == 1 {
                    self.delegate?.didFinishRequest(result, errorCode: 1, errorDesc: "", requestType: self.requestType)
                } else if result["status"].int == 1 {
                    self.delegate?.didFinishRequest(result, errorCode: 1, errorDesc: "", requestType: self.requestType)
                } else {
                    self.delegate?.didFailRequest(result, errorCode: 0, message: "", requestType: self.requestType)
                }
                
            }
        }) { (error, response) -> Void in
            self.isRequesting = false
            println("请求失败 \(error)")
            if response != nil {
                println("BaseAPI: url:\(response!.URL)")
            }
        }
    }
    
    func post(action: String, parameters: Dictionary<String, AnyObject>?) {
        var pars: Dictionary<String, AnyObject> = ["r_type": "1"]
        if parameters != nil {
            pars = parameters!
            pars.updateValue("1", forKey: "r_type")
        }
        
        self.isRequesting = true
        
        println("开始请求")
        http.POST(action, parameters: pars, success: { (response) -> Void in
            // 成功
            if response.responseObject != nil {
                
                var result = JSON(data: response.responseObject as NSData, options: NSJSONReadingOptions.MutableLeaves, error: nil)
                println("data: \(result)")
                
                if result["return"].int == 1 {
                    self.delegate?.didFinishRequest(result, errorCode: 1, errorDesc: "", requestType: self.requestType)
                } else if result["status"].int == 1 {
                    self.delegate?.didFinishRequest(result, errorCode: 1, errorDesc: "", requestType: self.requestType)
                } else {
                    self.delegate?.didFailRequest(result, errorCode: 0, message: "", requestType: self.requestType)
                }
                
            }
        }) { (error, response) -> Void in
            self.isRequesting = false
            println("请求失败 \(error)")
            if response != nil {
                println("BaseAPI: url:\(response!.URL)")
            }
        }
    }
}