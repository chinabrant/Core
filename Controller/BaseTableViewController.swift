//
//  BaseTableViewController.swift
//  Tianmijie
//
//  Created by Brant on 1/7/15.
//  Copyright (c) 2015 tianmitech. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {
    
    var tbview: UITableView!
    var containLoadMoreView: Bool = false
    var loadMoreView: LoadMoreView!
    var dataList: DataList!
    
    func initTableView() {
        self.containLoadMoreView = false
    }

    override func viewDidLoad() {
        initTableView()
        super.viewDidLoad()

        if self.containLoadMoreView {
            self.addLoadMoreView()
        }
    }
    
    func showNodataView(msg: String) {
        self.hideNodataView()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.loadMoreView.hidden = true
            
            var nodataView = UIView(frame: CGRectMake(0, 0, 320, 110))
            nodataView.backgroundColor = UIColor.clearColor()
            nodataView.tag = self.NodataViewTag
            var imageView = UIImageView(frame: CGRectMake(0, 0, 80, 80))
            imageView.image = UIImage(named: "common_no_data")
            imageView.center = CGPointMake(nodataView.width / 2, 40)
            nodataView.addSubview(imageView)
            nodataView.center = CGPointMake(self.tbview.width / 2, 150)
            var label = UILabel(frame: CGRectMake(0, 90, nodataView.width, 20))
            label.backgroundColor = UIColor.clearColor()
            label.text = msg
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor(red: 0x2c/255.0, green: 0x28/255.0, blue: 0x28/255.0, alpha: 1)
            label.font = UIFont.systemFontOfSize(15)
            nodataView.addSubview(label)
            
            self.tbview.addSubview(nodataView)
            self.tbview.reloadData()
        })
        
    }
    
    func showNetworkErrorView() {
        
    }
    
    func hideNodataView() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            var nodataView = self.tbview.viewWithTag(self.NodataViewTag)
            nodataView?.removeFromSuperview()
        })
    }
    
    func loadMoreData() {

    }
    
    func addLoadMoreView() {
        self.loadMoreView = LoadMoreView(frame: CGRectMake(0, 0, self.view.width, 44))
        self.tbview.tableFooterView = self.loadMoreView
    }
    
    func doneTableViewRequesting() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.dataList.isReloading = false
            if self.dataList.isLastPage() {
                self.loadMoreView.setFinishedState(true)
                
            } else {
                self.loadMoreView.setFinishedState(false)
            }
            
            if self.dataList.count() == 0 {
                self.loadMoreView.nomoreImageView.hidden = true
            } else {
                self.loadMoreView.nomoreImageView.hidden = false
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if self.containLoadMoreView {
            if self.scrollViewIsScrollToBottom(scrollView) && !self.dataList.isLastPage() {
                self.loadMoreData()
            }
        }
    }

    func scrollViewIsScrollToBottom(scrollView: UIScrollView) -> Bool {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height - 44 {
            return true
        } else {
            return false
        }
    }
}
