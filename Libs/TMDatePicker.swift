//
//  TMDatePicker.swift
//  Tianmijie
//
//  Created by Brant on 1/7/15.
//  Copyright (c) 2015 tianmitech. All rights reserved.
//

import UIKit
import Foundation

protocol TMDatePickerDelegate {
    func didSelectDate(date: NSDate)
}

class TMDatePicker: UIView {

    var datePicker: UIDatePicker = UIDatePicker()
    var topView: UIView = UIView()
    var delegate: TMDatePickerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.topView.frame = CGRectMake(0, 0, frame.size.width, 40)
        self.topView.backgroundColor = UIColor.whiteColor()
        self.topView.layer.borderColor = UIColor.grayColor().CGColor
        self.topView.layer.borderWidth = 0.5
        
        datePicker.frame = CGRectMake(0, 40, frame.size.width, 216)
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        self.height = 256
        self.addSubview(self.topView)
        self.addSubview(datePicker)
        
        self.backgroundColor = Constant.MainBackgroundColor
        
        // 设置按钮
        var cancel: UIButton = UIButton(frame: CGRectMake(0, 0, 100, 40))
        cancel.setTitle("取消", forState: UIControlState.Normal)
        cancel.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cancel.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
        self.topView.addSubview(cancel)
        
        var ok: UIButton = UIButton(frame: CGRectMake(self.width - 100, 0, 100, 40))
        ok.setTitle("确定", forState: UIControlState.Normal)
        ok.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        ok.addTarget(self, action: "ok", forControlEvents: UIControlEvents.TouchUpInside)
        self.topView.addSubview(ok)
    }
    
    func cancel() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.removeFromSuperview()
        })
    }
    
    func ok() {
        if delegate != nil {
            delegate?.didSelectDate(self.datePicker.date)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
