//
//  TMAlertView.swift
//  Tianmijie
//
//  Created by Brant on 1/6/15.
//  Copyright (c) 2015 tianmitech. All rights reserved.
//

import UIKit

protocol TMAlertViewDelegate {
    func tmAlertViewDidDismiss(tmAlertView: TMAlertView)
    func tmAlertViewDidClickReloading(tmAlertView: TMAlertView)
}

class TMAlertView: UIViewController {
    
    var msg: String = ""
    var msgLabel: UILabel = UILabel(frame: CGRectMake(0, 0, 160, 160))
    var delegate: TMAlertViewDelegate?
    var tag = 0
    var dismissBlock: (() -> Void)?
    
    // 单例
    class var sharedInstance : TMAlertView {
        struct Static {
            static let instance : TMAlertView = TMAlertView()
        }
        return Static.instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5) // UIColor(patternImage: UIImage(named: "common_alert_bg")!)
        
    }
    
    // 显示跳转第三方平台的view
    func showJumpView() {
        resetView()
        self.view.backgroundColor = UIColor(red: 0xe3/255.0, green: 0xdf/255.0, blue: 0xdf/255.0, alpha: 1)
        var imageView = UIImageView(frame: CGRectMake(0, 87, 270, 225))
        imageView.centerX = self.view.width / 2
        imageView.image = UIImage(named: "third_logo")
        self.view.addSubview(imageView)

        var loadingImageView = UIImageView(frame: CGRectMake(0, 19 + imageView.y + imageView.height, 186, 5))
        loadingImageView.animationImages = [UIImage(named: "third_loading_1")!, UIImage(named: "third_loading_2")!, UIImage(named: "third_loading_3")!, UIImage(named: "third_loading_4")!, UIImage(named: "third_loading_5")!, UIImage(named: "third_loading_6")!]
        loadingImageView.centerX = self.view.width / 2
        loadingImageView.animationDuration = 1
        self.view.addSubview(loadingImageView)
        loadingImageView.startAnimating()
        
        var label = UILabel(frame: CGRectMake(0, 0, self.view.width, 17))
        label.text = "正在前往第三方"
        label.font = UIFont.systemFontOfSize(15)
        label.textColor = UIColor(red: 0x43/255.0, green: 0x30/255.0, blue: 0x30/255.0, alpha: 1)
        label.textAlignment = NSTextAlignment.Center
        label.y = loadingImageView.y + loadingImageView.height + 28
        self.view.addSubview(label)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            var pv: UIView = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView
            pv.addSubview(self.view)
        })
        
    }
    
    func showLoadingMessage(message: String) {
        resetView()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        var contentView: UIView = UIView(frame: CGRectMake(0, 0, 140, 105))
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.center = CGPointMake(self.view.centerX, self.view.centerY)
        
        var imageView = UIImageView(frame: CGRectMake(0, 0, 47, 46))
        imageView.animationImages = [UIImage(named: "loading_1")!, UIImage(named: "loading_2")!, UIImage(named: "loading_3")!, UIImage(named: "loading_4")!, UIImage(named: "loading_5")!, UIImage(named: "loading_6")!, UIImage(named: "loading_7")!, UIImage(named: "loading_8")!]
        imageView.center = CGPointMake(contentView.width / 2, 19 + 23)
        imageView.animationDuration = 1
        contentView.addSubview(imageView)
        imageView.startAnimating()
        
        var label = UILabel(frame: CGRectMake(0, imageView.y + imageView.height + 10, contentView.width, 20))
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(15)
        label.text = message
        contentView.addSubview(label)
        
        self.view.addSubview(contentView)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            var pv: UIView = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView
            pv.addSubview(self.view)
        })
    }
    
    func showLoadingView() {
        self.showLoadingMessage("加载中...")
    }
    
    func show() {
        resetView()
        
        var contentView: UIView = UIView(frame: CGRectMake(0, 0, 160, 160))
        contentView.backgroundColor = UIColor.orangeColor()
        contentView.center = CGPointMake(self.view.centerX, self.view.centerY)
        msgLabel.text = msg
        msgLabel.contentMode = UIViewContentMode.Center
        msgLabel.textColor = UIColor.whiteColor()
        contentView.addSubview(msgLabel)
        self.view.addSubview(contentView)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            var pv: UIView = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView
            pv.addSubview(self.view)
        })
        dismiss(3)
    }
    
    func showMessageAutoHide(delay: NSTimeInterval, message: String) {
        resetView()
        
        var contentView: UIView = UIView(frame: CGRectMake(0, 0, 160, 80))
        contentView.backgroundColor = Constant.MainColor
        contentView.center = CGPointMake(self.view.centerX, self.view.centerY)
        msgLabel.text = msg
        msgLabel.textAlignment = NSTextAlignment.Center
        msgLabel.textColor = UIColor.whiteColor()
        msgLabel.frame = contentView.bounds
        contentView.addSubview(msgLabel)
        self.view.addSubview(contentView)
        
        msg = message
        msgLabel.text = message
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            var pv: UIView = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView
            pv.addSubview(self.view)
        })
        dismiss(delay)
    }
    
    func resetView() {
        self.view.alpha = 1
        removeAllViews()
    }
    
    func showSuccessMsgAutoHide(delay: NSTimeInterval, message: String, animated: Bool) {
        self.showView(message)
        dismiss(delay, animated: animated)
    }
    
    //
    func showSuccessMsgAutoHide(delay: NSTimeInterval, message: String, dismissBlock: ()-> Void) {
        self.dismissBlock = dismissBlock
        self.showView(message)
        dismiss(delay)
    }
    
    // 显示错误信息
    func showSuccessMsgAutoHide(delay: NSTimeInterval, message: String) {
        self.showView(message)
        dismiss(delay)
    }
    
    func showView(message: String) {
        resetView()
        var messageWidth = PublicFunc.getTextWidth(message, font: UIFont.systemFontOfSize(15))
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        var contentView: UIView = UIView(frame: CGRectMake(0, 0, 55 + messageWidth + 15, 80))
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.center = CGPointMake(self.view.centerX, self.view.centerY)
        
        var imageView = UIImageView(frame: CGRectMake(12, 0, 28, 28))
        imageView.center = CGPointMake(12 + 14, 40)
        imageView.image = UIImage(named: "common_success")
        contentView.addSubview(imageView)
        
        msgLabel.textColor = UIColor(red: 0x2c/255.0, green: 0x28/255.0, blue: 0x28/255.0, alpha: 1)
        msgLabel.text = msg
        msgLabel.font = UIFont.systemFontOfSize(15)
        msgLabel.textAlignment = NSTextAlignment.Left
        msgLabel.frame = CGRectMake(40 + 15, 0, messageWidth, 80)
        contentView.addSubview(msgLabel)
        self.view.addSubview(contentView)
        
        msg = message
        msgLabel.text = message
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            var pv: UIView = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView
            pv.addSubview(self.view)
        })
    }
    
    // 显示错误信息
    func showErrorMsgAutoHide(delay: NSTimeInterval, message: String) {
        resetView()
        var messageWidth = PublicFunc.getTextWidth(message, font: UIFont.systemFontOfSize(15))
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        var contentView: UIView = UIView(frame: CGRectMake(0, 0, 55 + messageWidth + 15, 80))
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.center = CGPointMake(self.view.centerX, self.view.centerY)
        
        var imageView = UIImageView(frame: CGRectMake(12, 0, 28, 28))
        imageView.center = CGPointMake(12 + 14, 40)
        imageView.image = UIImage(named: "common_error")
        contentView.addSubview(imageView)
        
        msgLabel.textColor = UIColor(red: 0x2c/255.0, green: 0x28/255.0, blue: 0x28/255.0, alpha: 1)
        msgLabel.text = msg
        msgLabel.font = UIFont.systemFontOfSize(15)
        msgLabel.textAlignment = NSTextAlignment.Left
        msgLabel.frame = CGRectMake(40 + 15, 0, messageWidth, 80)
        contentView.addSubview(msgLabel)
        
        
        
        self.view.addSubview(contentView)
        
        msg = message
        msgLabel.text = message
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            var pv: UIView = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView
            pv.addSubview(self.view)
        })
        dismiss(delay)
    }
    
    func reloading() {
//        println("reloading")
        if self.delegate != nil {
            self.delegate?.tmAlertViewDidClickReloading(self)
        }
    }
    
    // 显示网络错误的弹窗
    func showNetworkError() {
        resetView()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        var contentView: UIView = UIView(frame: CGRectMake(24, 0, PublicFunc.systemWidth() - 48, 333))

        contentView.backgroundColor = UIColor.whiteColor()
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.center = CGPointMake(self.view.centerX, self.view.centerY)
        
        var imageView = UIImageView(frame: CGRectMake(12, 0, 128, 95))
        imageView.center = CGPointMake(contentView.width / 2, 61 + 48)
        imageView.image = UIImage(named: "common_wifi")
        contentView.addSubview(imageView)
        
        msgLabel.textColor = UIColor(red: 0x2c/255.0, green: 0x28/255.0, blue: 0x28/255.0, alpha: 1)
        msgLabel.text = "没有网络，请检查网络设置!"
        msgLabel.font = UIFont.systemFontOfSize(15)
        msgLabel.textAlignment = NSTextAlignment.Center
        msgLabel.frame = CGRectMake(0, 95 + 61 + 38, contentView.width, 20)
        contentView.addSubview(msgLabel)
        
        var btn = UIButton(frame: CGRectMake(0, 0, 100, 43))
        btn.setTitle("重新加载", forState: UIControlState.Normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.backgroundColor = UIColor(red: 0xef/255.0, green: 0xab/255.0, blue: 0x26/255.0, alpha: 1)
        btn.center = CGPointMake(contentView.width / 2, msgLabel.y + msgLabel.height + 42)
        btn.addTarget(self, action: "reloading", forControlEvents: UIControlEvents.TouchUpInside)
        contentView.addSubview(btn)
        
        var closeBtn = UIButton(frame: CGRectMake(0, 0, 25, 25))
        closeBtn.setImage(UIImage(named: "common_close"), forState: UIControlState.Normal)
        closeBtn.center = CGPointMake(contentView.width - 8 - 13, 13 + 8)
        closeBtn.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        contentView.addSubview(closeBtn)
        
        self.view.addSubview(contentView)
        

        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            var pv: UIView = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView
            pv.addSubview(self.view)
        })
    }
    
    func dismiss(delay: NSTimeInterval) {
        NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: "dismiss", userInfo: nil, repeats: false)
    }
    
    func dismiss(delay: NSTimeInterval, animated: Bool) {
        if animated {
            NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: "dismissAnimated", userInfo: nil, repeats: false)
        } else {
            NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: "dismiss", userInfo: nil, repeats: false)
        }
    }
    
    func show(message: String) {
        resetView()
        
        var contentView: UIView = UIView(frame: CGRectMake(0, 0, 160, 160))
        contentView.backgroundColor = UIColor.orangeColor()
        contentView.center = CGPointMake(self.view.centerX, self.view.centerY)
        msgLabel.text = msg
        msgLabel.contentMode = UIViewContentMode.Center
        msgLabel.textColor = UIColor.whiteColor()
        contentView.addSubview(msgLabel)
        self.view.addSubview(contentView)
        
        msg = message
        msgLabel.text = message
        self.show()
    }
    
    func dismiss() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "common_alert_bg")!)
            println("dismiss alert view")
            if self.view.superview != nil {
                self.view.removeFromSuperview()
                if self.dismissBlock != nil {
                    self.dismissBlock!()
                    self.dismissBlock = nil
                }
                
                if self.delegate != nil {
                    self.delegate?.tmAlertViewDidDismiss(self)
                }
            }
        })
        
    }
    
    func dismissAnimated() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if self.view.superview != nil {
                UIView.animateWithDuration(3, animations: { () -> Void in
                        self.view.alpha = 0
                    }, completion: { (completed: Bool) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.view.removeFromSuperview()
                        })
                        
                        if self.delegate != nil {
                            self.delegate?.tmAlertViewDidDismiss(self)
                        }
                })

                
            }
        })
    }

    func removeAllViews() {
        var views: Array = self.view.subviews
        for view: AnyObject in views {
            (view as UIView).removeFromSuperview()
        }
    }
    
}
