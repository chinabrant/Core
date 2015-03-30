//
//  Constant.swift
//  Tianmijie
//
//  Created by Brant on 12/31/14.
//  Copyright (c) 2014 tianmitech. All rights reserved.
//

import Foundation
import UIKit

/**
* 定义一些常量
*/
struct Constant {
    static let MainBackgroundColor: UIColor = UIColor(red: 0xe3/255.0, green: 0xdf/255.0, blue: 0xdf/255.0, alpha: 1)
    static let MainColor: UIColor = UIColor.hexValue("#8cc20a")
    
//    static let isIOS7 = (Float(UIDevice.currentDevice().systemVersion) == 7.0) ? true : false
    
    // 通知
    static let NotificationLoginSuccess = "LoginSuccess"
    static let NotificationLogout = "LogoutSuccess"
    static let NotificationUpdate = "Force_update"
    
    // ShareSDK
    static let ShareSDKKey = "bb337d94214"
    
    static let SinaKey = "2709179551"
    static let SinaSecret = "f14aed52c8c6bb8060250ce0db85632b"
    static let SinaRedirectUri = "http://www.tianmijie.com"
    
    static let WechatAppid = "wxbc8c3c83ba8bdde9"
    
    static let QZoneKey = "100371282"
    static let QZoneSecret = "aed9b0303e3ed1e27bae87c33761161d"
    
    static let NodataStr = "空空如也哟~"
    
    static let PI = 3.14159265358979324
    
    static let APPSOTRE_APP_ID = "897834118"
    
    static let Token = "f01adDplVqxhH2I5AYKe+8JB4uh5i8Nl7gx+erV6EkexulUxgA1"
    static let Channel = "ios"
    static let Version = "1.4"
}
