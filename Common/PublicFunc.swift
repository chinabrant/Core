//
//  PublicFunc.swift
//  Tianmijie
//
//  Created by Brant on 1/23/15.
//  Copyright (c) 2015 tianmitech. All rights reserved.
//

import Foundation
import UIKit

class PublicFunc {
    let x_pi = 3.14159265358979324 * 3000.0 / 180.0
    
    // 判断是否有网络
    // (reachability.currentReachabilityStatus().value == ReachableViaWiFi.value)
    class func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: NetworkStatus = reachability.currentReachabilityStatus()
        return networkStatus != NetworkStatus.NotReachable
    }
    
    class func formatDate(date: NSDate, formatString: String) -> String {
        var formatter = NSDateFormatter()
        formatter.dateFormat = formatString
        return formatter.stringFromDate(date)
    }
    
    // 屏幕宽度
    class func systemWidth() -> CGFloat {
        var rect = UIScreen.mainScreen().bounds
        return rect.size.width
    }
    
    // 屏幕高度
    class func screenHeight() -> CGFloat {
        var rect = UIScreen.mainScreen().bounds
        return rect.size.height
    }
    
   /*
    - (UIImage *)resizeImage:(UIImage *)image
    withQuality:(CGInterpolationQuality)quality
    rate:(CGFloat)rate
    {
    UIImage *resized = nil;
    CGFloat width = image.size.width * rate;
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
    }
*/
    // 不失真的放大  rate：放大系数
    class func resizeImage(image: UIImage, quality: CGInterpolationQuality, rate: CGFloat) -> UIImage? {
        var width = image.size.width * rate
        var height = image.size.height * rate
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        var context = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(context, quality)
        image.drawInRect(CGRectMake(0, 0, width, height))
        var resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized
    }

    
    // 验证电话格式
    class func isTelNumber(num:NSString)->Bool {
        var mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        var  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        var  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        var  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        var regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        var regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        var regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        var regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile!.evaluateWithObject(num) == true)
            || (regextestcm!.evaluateWithObject(num)  == true)
            || (regextestct!.evaluateWithObject(num) == true)
            || (regextestcu!.evaluateWithObject(num) == true)) {
            return true
        } else {
            return false
        }
    }
    
    // 字符串宽度
    class func getTextWidth(text: NSString, font: UIFont) -> CGFloat {
        var textSize: CGSize = text.boundingRectWithSize(CGSizeMake(CGFloat.max, 20), options: NSStringDrawingOptions.UsesFontLeading, attributes: [NSFontAttributeName: font], context: nil).size
        
        return textSize.width
    }
    
    // 字符串高度
    class func getTextHeight(text: NSString, font: UIFont, width: CGFloat) -> CGFloat {
        var textSize: CGSize = text.boundingRectWithSize(CGSizeMake(width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size
        
        return textSize.height
    }
    
    
    /*
    const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    // 高德到百度
    void bd_encrypt(double gg_lat, double gg_lon, double &bd_lat, double &bd_lon)
    {
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    bd_lon = z * cos(theta) + 0.0065;
    bd_lat = z * sin(theta) + 0.006;
    }
    // 百度到高德
    void bd_decrypt(double bd_lat, double bd_lon, double &gg_lat, double &gg_lon)
    {
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    gg_lon = z * cos(theta);
    gg_lat = z * sin(theta);
    }
*/
    
    class func baiduToGaode(lat: Double, lon: Double) -> (lat: Double, lon: Double){
        var x = lon - 0.0065, y = lat - 0.006
        var z = sqrt(x * x + y * y) - 0.00002 * sin(y * (3.14159265358979324 * 3000.0 / 180.0))
        var theta = atan2(y, x) - 0.000003 * cos(x * (3.14159265358979324 * 3000.0 / 180.0))
        return (z * cos(theta), z * sin(theta))
    }
    
    class func gaodeToBaidu(lat: Double, lon: Double) -> (lat: Double, lon: Double) {
        var x = lon, y = lat
        var z = sqrt(x * x + y * y) + 0.00002 * sin(y * (3.14159265358979324 * 3000.0 / 180.0))
        var theta = atan2(y, x) - 0.000003 * cos(x * (3.14159265358979324 * 3000.0 / 180.0))
        return (z * cos(theta) + 0.0065, z * sin(theta) + 0.006)
    }
    
    class func wgsToGaode(lat: Double, lon: Double) -> (lat: Double, lon: Double) {
        if PublicFunc.outOfChina(lat, lon: lon) {
            return (lat, lon)
        }
        
        var dLat = transformLat(lon - 105.0, y: lat - 35.0)
        var dLon = transformLon(lon - 105.0, y: lat - 35.0)
        var radLat = lat / 180 * Constant.PI
        var magic = sin(radLat)
        var sqrtMagic = sqrt(magic)
        dLat = (dLat * 180.0) / ((6378245.0 * (1 - 0.00669342162296594323)) / (magic * sqrtMagic) * Constant.PI)
        dLon = (dLon * 180.0) / (6378245.0 / sqrtMagic * cos(radLat) * Constant.PI)
        
        return ((lat + dLat), (lon + dLon))
    }
    
    /*   wgs 国际标准到高德
    const double pi = 3.14159265358979324;
    
    //
    // Krasovsky 1940
    //
    // a = 6378245.0, 1/f = 298.3
    // b = a * (1 - f)
    // ee = (a^2 - b^2) / a^2;
    const double a = 6378245.0;
    const double ee = 0.00669342162296594323;
    
    //
    // World Geodetic System ==> Mars Geodetic System
    public static void transform(double wgLat, double wgLon, out double mgLat, out double mgLon)
    {
    if (outOfChina(wgLat, wgLon))
    {
    mgLat = wgLat;
    mgLon = wgLon;
    return;
    }
    double dLat = transformLat(wgLon - 105.0, wgLat - 35.0);
    double dLon = transformLon(wgLon - 105.0, wgLat - 35.0);
    double radLat = wgLat / 180.0 * pi;
    double magic = Math.Sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = Math.Sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    dLon = (dLon * 180.0) / (a / sqrtMagic * Math.Cos(radLat) * pi);
    mgLat = wgLat + dLat;
    mgLon = wgLon + dLon;
    }
    
    static bool outOfChina(double lat, double lon)
    {
    if (lon < 72.004 || lon > 137.8347)
    return true;
    if (lat < 0.8293 || lat > 55.8271)
    return true;
    return false;
    }
    
    static double transformLat(double x, double y)
    {
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.Sqrt(Math.Abs(x));
    ret += (20.0 * Math.Sin(6.0 * x * pi) + 20.0 * Math.Sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * Math.Sin(y * pi) + 40.0 * Math.Sin(y / 3.0 * pi)) * 2.0 / 3.0;
    ret += (160.0 * Math.Sin(y / 12.0 * pi) + 320 * Math.Sin(y * pi / 30.0)) * 2.0 / 3.0;
    return ret;
    }
    
    static double transformLon(double x, double y)
    {
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.Sqrt(Math.Abs(x));
    ret += (20.0 * Math.Sin(6.0 * x * pi) + 20.0 * Math.Sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * Math.Sin(x * pi) + 40.0 * Math.Sin(x / 3.0 * pi)) * 2.0 / 3.0;
    ret += (150.0 * Math.Sin(x / 12.0 * pi) + 300.0 * Math.Sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return ret;
    }
    }
    */
    
    class func outOfChina(lat: Double, lon: Double) -> Bool {
        if (lon < 72.004 || lon > 137.8347) {
            return true
        }
        
        if lat < 0.8293 || lat > 55.8271 {
            return true
        }
        
        return false
    }
    
    class func transformLon(x: Double, y: Double) -> Double {
        var ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y // + 0.1 * sqrt(abs(x))
        ret += 0.1 * sqrt(abs(x))
        ret += (20.0 * sin(6.0 * x * Constant.PI) + 20.0 * sin(2.0 * x * Constant.PI)) * 2.0 / 3.0
        ret += (20.0 * sin(x * Constant.PI) + 40.0 * sin(x / 3.0 * Constant.PI)) * 2.0 / 3.0
        ret += (150.0 * sin(x / 12.0 * Constant.PI) + 300.0 * sin(x / 30.0 * Constant.PI)) * 2.0 / 3.0
        
        return ret
    }
    
    class func transformLat(x: Double, y: Double) -> Double {
        var ret = -100.0 + 2.0 * x + 3.0 * y // + 0.2 * y * y
        ret += 0.2 * y * y
        ret += 0.1 * x * y
        ret += 0.2 * sqrt(abs(x))
        ret += (20.0 * sin(6.0 * x * Constant.PI) + 20.0 * sin(2.0 * x * Constant.PI)) * 2.0 / 3.0
        ret += (20.0 * sin(y * Constant.PI) + 40.0 * sin(y / 3.0 * Constant.PI)) * 2.0 / 3.0
        ret += (160.0 * sin(y / 12.0 * Constant.PI) + 320.0 * sin(y * Constant.PI / 30.0)) * 2.0 / 3.0
        
        return ret
    }
    
    class func resizeImage(image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height))
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        var resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
    }
}


