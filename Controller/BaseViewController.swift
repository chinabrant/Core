//
//  BaseViewController.swift
//  Tianmijie
//
//  Created by Brant on 12/25/14.
//  Copyright (c) 2014 tianmitech. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, TMAlertViewDelegate, BaseAPIDelegate {
    
    var fatherViewController: UIViewController?
    let NodataViewTag = 999
    let NetworkErrorViewTag = 777
    var alert: TMAlertView = TMAlertView()
    var shareButton: UIButton!
    var collectButton: UIButton!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constant.MainBackgroundColor
        
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
//        [self.navigationItem setBackBarButtonItem:backItem];
        
        self.hideBackTitle()
        alert.delegate = self
    }
    
    // MARK: - TMAlertViewDelegate
    func tmAlertViewDidDismiss(tmAlertView: TMAlertView) {
        
    }
    
    func tmAlertViewDidClickReloading(tmAlertView: TMAlertView) {
        
    }
    
    func hideBackTitle() {
        var backItem: UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Bordered, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func createShareButton() {
        self.shareButton = UIButton(frame: CGRectMake(-5, 0, 21, 23))
        self.shareButton.setImage(UIImage(named: "nav_share"), forState: UIControlState.Normal)
        self.shareButton.addTarget(self, action: "share", forControlEvents: UIControlEvents.TouchUpInside)
        var share: UIBarButtonItem = UIBarButtonItem(customView: self.shareButton)
        self.navigationItem.rightBarButtonItem = share
    }
    
    func createShareAndCollectionButton() {
        self.shareButton = UIButton(frame: CGRectMake(-5, 0, 21, 23))
        self.shareButton.setImage(UIImage(named: "nav_share"), forState: UIControlState.Normal)
        self.shareButton.addTarget(self, action: "share", forControlEvents: UIControlEvents.TouchUpInside)
        var share: UIBarButtonItem = UIBarButtonItem(customView: self.shareButton)
        
        self.collectButton = UIButton(frame: CGRectMake(5, 0, 24, 22))
        self.collectButton.setImage(UIImage(named: "nav_collection_normal"), forState: UIControlState.Normal)
        self.collectButton.setImage(UIImage(named: "nav_collection_selected"), forState: UIControlState.Selected)
        self.collectButton.addTarget(self, action: "collection", forControlEvents: UIControlEvents.TouchUpInside)
        var collect: UIBarButtonItem = UIBarButtonItem(customView: self.collectButton)
        self.navigationItem.rightBarButtonItems = [share, collect]
    }
    
    func share() {
        
    }
    
    
    func collection() {
        
    }
    
    func createLeftMenu() {
        var leftItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_menu"), style: UIBarButtonItemStyle.Bordered, target: self, action: "menuPressed") // = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "menuPressed")
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func createCancelButton() {
        var leftItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func call(num: String) {
        var number = String("tel://\(num)")
        UIApplication.sharedApplication().openURL(NSURL(string: number)!)
    }
    
    func didFinishRequest(result: JSON, errorCode: Int, errorDesc: String, requestType: RequestType) {
        TMAlertView.sharedInstance.dismiss()
        
    }
    
    func didFailRequest(result: JSON, errorCode: Int, message: String, requestType: RequestType) {
        TMAlertView.sharedInstance.dismiss()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            TMAlertView.sharedInstance.showErrorMsgAutoHide(1, message: result["info"].string!)
        })
        
    }
    
    func didFailWithNetworkError(error: NSError, requestType: RequestType) {
        TMAlertView.sharedInstance.showErrorMsgAutoHide(1, message: "网络错误，请稍候重试")
    }
}
