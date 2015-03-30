//
//  LocationControl.swift
//  Tianmijie
//
//  Created by Brant on 1/4/15.
//  Copyright (c) 2015 tianmitech. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationControlDelegate {
    func didUpdateLocation(location: CLLocation)
    func didFailUpdateLocation(error: NSError)
}

class LocationControl: NSObject, CLLocationManagerDelegate {
    let locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var delegate: LocationControlDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        //设备使用电池供电时最高的精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //精确到1000米,距离过滤器，定义了设备移动后获得位置信息的最小距离
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
    }
    
    func startUpdateCurrentLocation() {
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        locationManager.stopUpdatingLocation()
        
        currentLocation = locations.last as CLLocation
        
//        getCityName(currentLocation)
        println("定位成功: lat \(currentLocation.coordinate.latitude)  lon \(currentLocation.coordinate.longitude)")
        // 将wgs坐标转成高德坐标
//        var loc = PublicFunc.wgsToGaode(currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
//        // 将高德坐标转换成百度坐标
//        loc = PublicFunc.gaodeToBaidu(loc.lat, lon: loc.lon)
//        currentLocation = CLLocation(latitude: loc.lon, longitude: loc.lat)
//        println("111定位成功: lat \(currentLocation.coordinate.latitude)  lon \(currentLocation.coordinate.longitude)")
        
        // 保存定位到的信息
        var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue("\(currentLocation.coordinate.latitude)", forKey: "lat")
        userDefaults.setValue("\(currentLocation.coordinate.longitude)", forKey: "lon")
        userDefaults.synchronize()
        
        if delegate != nil {
            delegate?.didUpdateLocation(currentLocation)
        }
    }
    
    func getCityName(currLocation: CLLocation) {
        var geocoder = CLGeocoder()
        var p: CLPlacemark?
        geocoder.reverseGeocodeLocation(currLocation, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                println("reverse geodcode fail: \(error.localizedDescription)")
                return
            }
            let pm = placemarks as [CLPlacemark]
            if (pm.count > 0) {
                p = placemarks[0] as? CLPlacemark
                println(p)
            } else {
                println("No Placemarks!")
            }
        })
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        locationManager.stopUpdatingLocation()
        println(error)
        if delegate != nil {
            delegate?.didFailUpdateLocation(error)
        }
    }
    
    class func getDefaultLocation() -> (lat: String, lon: String) {
        var lat: String?
        var lon: String?
        var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if userDefaults.valueForKey("lat") != nil {
            lat = userDefaults.valueForKey("lat") as NSString
            
        } else {
            lat = "22.5466096500011"
        }
        
        if userDefaults.valueForKey("lon") != nil {
            lon = userDefaults.valueForKey("lon") as NSString
        } else {
            lon = "114.045614140891"
        }
    
        return (lat!, lon!)
    }
}
