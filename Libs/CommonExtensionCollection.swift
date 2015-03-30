//
//  CommonExtensionCollection.swift
//  CECDemo
//
//  Created by QinChong on 11/20/14.
//  Copyright (c) 2014 Damon Qin. All rights reserved.
//

import UIKit
import CoreImage

let errorMessage: String = "Your view must have superview, so we can position it."

// MARK: Extension of UIView
extension UIView {
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set (newX) {
            var frame: CGRect = self.frame
            frame.origin.x = newX
            self.frame = frame
        }
    }
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set (newY) {
            var frame: CGRect = self.frame
            frame.origin.y = newY
            self.frame = frame
        }
    }
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set (newWidth) {
            var frame: CGRect = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set (newHeight) {
            var frame: CGRect = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set (newOrigin) {
            var frame: CGRect = self.frame
            frame.origin = newOrigin
            self.frame = frame
        }
    }
    var size: CGSize {
        get {
            return self.frame.size
        }
        set (newSize) {
            var frame: CGRect = self.frame
            frame.size = newSize
            self.frame = frame
        }
    }
    var bottom: CGFloat {
        get {
            return self.y + self.height
        }
        set (newBottom) {
            self.y = newBottom - self.height
        }
    }
    var bottomMargin: CGFloat {
        get {
            assert((self.superview != nil), errorMessage)
            return self.superview!.height - self.y - self.height
        }
        set (newBottomMargin) {
            assert((self.superview != nil), errorMessage)
            self.y = self.superview!.height - self.height - newBottomMargin
        }
    }
    var right: CGFloat {
        get {
            return self.x + self.width
        }
        set (newRight) {
            self.x = newRight - self.width
        }
    }
    var rightMargin: CGFloat {
        get {
            assert((self.superview != nil), errorMessage)
            return self.superview!.width - self.x - self.width
        }
        set (newRightMargin) {
            assert((self.superview != nil), errorMessage)
            self.x = self.superview!.width - self.width - newRightMargin
        }
    }
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set (newCenterX) {
            self.center = CGPointMake(newCenterX, self.center.y)
        }
    }
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set (newCenterY) {
            self.center = CGPointMake(self.center.x, newCenterY)
        }
    }
}

// MARK: Extension of UIColor
extension UIColor {
    
    class func hexValueWithAlpha(var hexColor: String, alpha: CGFloat? = 1.0) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = alpha!
        
        if hexColor.hasPrefix("#") {
            hexColor = hexColor.substringFromIndex(advance(hexColor.startIndex, 1))
        }
        
        let scanner = NSScanner(string: hexColor)
        var hexComponent: CUnsignedLongLong = 0
        let scannerResult: Bool = scanner.scanHexLongLong(&hexComponent)
        
        func verifyHexValue() -> Bool {
            var length = countElements(hexColor)
            if (length == 3 || length == 6) && scannerResult {
                return true
            } else {
                return false
            }
        }
        
        let checkResult = verifyHexValue()
        assert(checkResult, "Invalid Hex Color Value")
        
        switch countElements(hexColor) {
        case 3:
            red = CGFloat((hexComponent & 0xF00) >> 8 * 17) / 255.0
            green = CGFloat((hexComponent & 0x0F0) >> 4 * 17) / 255.0
            blue = CGFloat(hexComponent & 0x00F * 17) / 255.0
        case 6:
            red = CGFloat((hexComponent & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexComponent & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(hexComponent & 0x0000FF) / 255.0
        default:
            red = 1.0
            green = 1.0
            blue = 1.0
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func hexValue(var hexColor: String) -> UIColor {
        return self.hexValueWithAlpha(hexColor, alpha: 1.0)
    }
    
}

// MARK: - Extension for String
extension String  {
    var md5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        var hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return String(format: hash)
    }
    
    /**   coreimage
    *返回当前字符串对应的二维码图像
    *二维码的实现就是将字符串传递给滤镜，滤镜直接转换生成二维码图片
    **/
    func createQRcode() -> UIImage? {
        //1.实例化一个滤镜
        var filter = CIFilter(name: "CIQRCodeGenerator")
        // 1.1>设置filter的默认值
        // 因为之前如果使用过滤镜，输入有可能会被保留，因此，在使用滤镜之前，最好恢复默认设置
        filter.setDefaults()
        // 2.将传入的字符串转换为NSData
        var data = self.dataUsingEncoding(NSUTF8StringEncoding)
        // 3.将NSData传递给滤镜（通过KVC的方式，设置inputMessage）
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("M", forKey: "inputCorrectionLevel")
        // 4.由filter输出图像
        var outputImage = filter.outputImage
        // 5.将CIImage转换为UIImage
        var qrImage = UIImage(CIImage: outputImage)
        return qrImage
    }
}