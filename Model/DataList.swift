//
//  DataList.swift
//  Tianmijie
//
//  Created by Brant on 12/29/14.
//  Copyright (c) 2014 tianmitech. All rights reserved.
//

import Foundation

class DataList {
    var isReloading: Bool = false
    var isReachLastPage: Bool = false
    var currentPage: Int = 0
    var totalRecord: Int = 0
    var list: [AnyObject] = [AnyObject]()
    
    func loadDataFromJSON(json: JSON, requestType: RequestType) {
        if self.isReloading {
            self.list.removeAll(keepCapacity: false)
            self.currentPage = 1
            self.isReachLastPage = false
        }
        
        if self.list.count == 0 {
            self.currentPage = 1
        } else {
            currentPage++
        }
        
        var totalPage = json["page"]["page_total"].int
        var page = json["page"]["page"].int
        
        if totalPage <= page {
            self.isReachLastPage = true
        } else {
            self.isReachLastPage = false
        }
    }
    
    func count() -> Int {
        return list.count
    }
    
    func objectAtInde(index: Int) -> AnyObject {
        return list[index]
    }
    
    func removeAllObjects() {
        list.removeAll(keepCapacity: false)
    }
    
    func isLastPage() ->Bool {
        return isReachLastPage
    }
}
