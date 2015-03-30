//
//  NetAction.swift
//  ZaoCanHui
//
//  Created by Brant on 3/19/15.
//  Copyright (c) 2015 tianmitech. All rights reserved.
//

import Foundation

struct NetAction {
    static let Login = "act=login"                          // 用户登录
    static let VerifyPhone = "act=register_verify_phone"    // 验证码发送
    static let VerifyCode = "act=register_verify_code"      // 校验验证码
    static let Register = "act=register_do_phone"           // 用户注册
    static let ChangePwd = "act=pwd"                        // 修改密码
    static let ModifyUserinfo = "act=userinfo_mod"          // 修改用户信息
    static let UploadAvatar = "act=avatar"                  // 上传头像
    static let UserInfo = "act=userinfo"                    // 用户详细信息
    static let Feedback = "act=feedback"                    // 用户反馈
    static let Aboutus = "act=appabout"                     // 关于我们
    
    static let StorageDetail = "act=storageitem"            // 自提点详情
    static let StoreDetail = "act=supplieritem"             // 门店详情
    static let StoreList = "act=merchantlist"               // 商家列表
    static let StoreCateList = "act=cate_list"              // 地区列表
    static let AreaList = "act=quan"                        // 商圈列表
    static let CurrentStorage = "act=init"                  // 根据位置点取提餐点
    static let HomeIndex = "act=index"                      // 首页的商品列表
    
    static let AddTopic = "act=addshare"                    // 添加晒早
    
    static let OurGoodsDetail = "act=goodsdesc"             // 早餐详情
}