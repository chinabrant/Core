//
//  TMImageLoader.swift
//  Tianmijie
//
//  Created by Brant on 1/7/15.
//  Copyright (c) 2015 tianmitech. All rights reserved.
//

import UIKit
import Foundation

class TMImageLoader {
    var cache = NSCache()
    let http: HTTPTask = HTTPTask()
    
    class var sharedLoader : TMImageLoader {
        struct Static {
            static let instance : TMImageLoader = TMImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            var data: NSData? = self.cache.objectForKey(urlString) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData)
                dispatch_async(dispatch_get_main_queue(), {() in
                    completionHandler(image: image, url: urlString)
                })
                return
            }
            
            var downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                if (error != nil) {
                    completionHandler(image: nil, url: urlString)
                    return
                }
                
                if data != nil {
                    let image = UIImage(data: data)
                    self.cache.setObject(data, forKey: urlString)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: urlString)
                    })
                    return
                }
                
            })
            downloadTask.resume()
        })
        
    }
    
    func loadImage(url: String, placeholderImage: UIImage) {
        http.download("url", parameters: nil, progress: { (progress: Double) -> Void in
            
        }, success: { (response) -> Void in
            
        }) { (error, response) -> Void in
            
        }
    }
}