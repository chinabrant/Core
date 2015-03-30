//
//  SpinnerView.swift
//  ZaoCanHui
//
//  Created by Brant on 3/26/15.
//  Copyright (c) 2015 tianmitech. All rights reserved.
//

import UIKit

protocol SpinnerViewDelegate {
    func didClickMenu(index: Int)
}

// navigation bar 上的一个下拉菜单
class SpinnerView: UIView {
    
    var spinnerWidth: CGFloat = 90
    var itemHeight: CGFloat = 40
    var data: [(img: String, title: String)]!
    var delegate: SpinnerViewDelegate?

    init(data: [(img: String, title: String)]) {
        self.data = data
        
        var hei: CGFloat = 6 + CGFloat(data.count) * itemHeight + CGFloat(data.count)
        super.init(frame: CGRectMake(PublicFunc.systemWidth() - 95, 0, 90, hei))
        
        self.setupViews()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        var hei: CGFloat = 6 + CGFloat(data.count) * itemHeight + CGFloat(data.count)
        var image = UIImage(named: "common_spinner_bg")
        image?.resizableImageWithCapInsets(UIEdgeInsetsMake(30, 20, 20, 40))
        var backImageView = UIImageView(frame: CGRectMake(0, 0, 90, hei))
        backImageView.image = image
        self.addSubview(backImageView)
        
        for var i = 0; i < data.count; i++ {
            var da = data[i]
            var item = createItem(da.img, title: da.title, index: i)
            self.addSubview(item)
        }
    }
    
    func createItem(img: String, title: String, index: Int) -> UIView {
        var item = UIView(frame: CGRectMake(0, (CGFloat(index) + 6 + CGFloat(index) * 40), spinnerWidth, 40))
        var imageView = UIImageView(frame: CGRectMake(5, 5, 30, 30))

        imageView.image = UIImage(named: img)
        item.addSubview(imageView)
        
        var titleLabel = UILabel(frame: CGRectMake(40, 5, 90 - 40 - 10, 30))
        titleLabel.text = title
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(15)
        item.addSubview(titleLabel)
        
        item.tag = index
        
        item.userInteractionEnabled = true
        var tap = UITapGestureRecognizer(target: self, action: "tap:")
        item.addGestureRecognizer(tap)
        
        return item
    }
    
    func tap(tap: UITapGestureRecognizer) {
        self.removeFromSuperview()
        var index = tap.view?.tag
        if self.delegate != nil {
            self.delegate?.didClickMenu(index!)
        }
    }
}
