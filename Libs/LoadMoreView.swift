//
//  LoadMoreView.swift
//  Tianmijie
//
//  Created by 吴述军 on 15/1/14.
//  Copyright (c) 2015年 tianmitech. All rights reserved.
//

import UIKit

class LoadMoreView: UIView {
    
    var activityIndicatorView: UIActivityIndicatorView!
    var textLabel: UILabel!
    var nomoreImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.activityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(110, 8, 20, 30))
        self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.addSubview(self.activityIndicatorView)
        
        self.textLabel = UILabel(frame: CGRectMake(140, 10, 120, 15))
        self.textLabel.text = "正在加载..."
        self.textLabel.textColor = UIColor.lightGrayColor()
        self.textLabel.backgroundColor = UIColor.clearColor()
        self.textLabel.font = UIFont.systemFontOfSize(14)
        self.textLabel.hidden = true
//        self.addSubview(self.textLabel)
        
        nomoreImageView = UIImageView(frame: CGRectMake(0, 0, 130, 26))
        nomoreImageView.image = UIImage(named: "common_nomore")
        nomoreImageView.center = CGPointMake(self.centerX, self.centerY)
        self.nomoreImageView.hidden = true
        self.addSubview(nomoreImageView)
    }
    
    func setFinishedState(state: Bool) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.nomoreImageView.hidden = false
            if state {
                self.nomoreImageView.width = 130
                self.nomoreImageView.image = UIImage(named: "common_nomore")
            } else {
                self.nomoreImageView.width = 150
                self.nomoreImageView.image = UIImage(named: "common_loadmore")
            }
        })
        
//        self.hidden = state
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
