//
//  ColorUtil.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class var productBase: ProductBaseColor { return ProductBaseColor() }
    
    class var palette: ColorPalet { return ColorPalet() }
}

protocol ApplicationColor {
    var tint:UIColor { get }
    var sub:UIColor { get }
    var accent:UIColor { get }
    
    var primaryText:UIColor { get }
    var secondatyText:UIColor { get }
    var background: UIColor { get }
}

struct ProductBaseColor:ApplicationColor {
    var tint: UIColor { return UIColor.blue }
    var sub: UIColor { return UIColor.cyan }
    var accent: UIColor { return UIColor.red }
    
    var primaryText: UIColor { return UIColor.black }
    var secondatyText: UIColor { return UIColor.black }
    var background: UIColor { return UIColor.white }
    
}

struct ColorPalet {
    var halfBlack:UIColor        = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)//UIColor(hexCode: 0x000000, alpha: 0.5)
    var deepBlack:UIColor        = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)//UIColor(hexCode: 0x000000, alpha: 0.75)
    var pureBlack:UIColor        = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)//UIColor(hexCode: 0x000000, alpha: 1)
    
    var lightBlack:UIColor       = #colorLiteral(red: 0.2226176858, green: 0.2226238251, blue: 0.222620517, alpha: 1)//UIColor(hexCode: 0x2b2b2b, alpha: 1)
    
    var lightestGray:UIColor     = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 0.1)//UIColor(hexCode: 0x474747, alpha: 0.10)
    var lighterGray:UIColor      = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 0.17)//UIColor(hexCode: 0x474747, alpha: 0.17)
    var lightGray:UIColor        = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 0.25)//UIColor(hexCode: 0x474747, alpha: 0.25)
    var deepGray:UIColor         = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 0.5)//UIColor(hexCode: 0x474747, alpha: 0.50)
    var darkGray:UIColor         = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 0.56)//UIColor(hexCode: 0x474747, alpha: 0.56)
    var darkerGray:UIColor       = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 0.75)//UIColor(hexCode: 0x474747, alpha: 0.75)
    var darkestGray:UIColor      = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 1)//UIColor(hexCode: 0x474747, alpha: 1)
    
    var yearGray:UIColor         = #colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 0.75)//UICOlor(hexCode: 0x616161, alpha: 0.75)
    var lineGray:UIColor         = #colorLiteral(red: 0.5293668509, green: 0.5292618871, blue: 0.5255832076, alpha: 1)//UICOlor(hexCode: 0x747473, alpha: 1)
    
    var drawerCaption:UIColor    = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 0.2)//UIColor(hexCode: 0x808080, alpha: 0.2)
    var verticalLineGray:UIColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)//UIColor(hexCode: 0xb9b9b9, alpha: 1)
    
    var halfWhite:UIColor        = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)//UIColor(hexCode: 0xffffff, alpha: 0.5)
    var brightWhite:UIColor      = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9)//UIColor(hexCode: 0xffffff, alpha: 0.9)
    var pureWhite:UIColor        = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)//UIColor(hexCode: 0xffffff, alpha: 1)
}

extension UIColor {
    struct RGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        
        init (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            self.red = red / 255
            self.green = green / 255
            self.blue = blue / 255
            self.alpha = alpha
        }
    }
    
    // 16進数カラーコードからUIColorを生成   UIColor(rgb: 0x00ff00) :: green
    convenience init(rgb: Int) {
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >>  8) / 255.0
        let b = CGFloat( rgb & 0x0000FF       ) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    convenience init(RGB:RGB) {
        self.init(red: RGB.red, green:RGB.green, blue:RGB.blue, alpha:RGB.alpha)
    }
    
    // カラーコード（16進数・文字列）
    var rgbString: String {
        var r:CGFloat = -1, g:CGFloat = -1, b:CGFloat = -1, a:CGFloat = -1
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        var ret = ""
        ret += UIColor.hexStringByCGFloat(value: r)
        ret += UIColor.hexStringByCGFloat(value: g)
        ret += UIColor.hexStringByCGFloat(value: b)
        return ret
    }
    
    // カラーコード（16進数・数値）
    var rgb: Int {
        let i = self.intValues
        return (i.red * 0x010000) + (i.green * 0x000100) + i.blue
    }
}

extension UIColor {
    
    private static let maxHex: Float = 0xFFFFFFFF
    private static let minHex: Float = 0x0
    
    private static let prefix = "#"
    
    private class func substring(string: String, location: Int, length: Int? = nil) -> String {
        let strlen = string.count
        var len = length ?? strlen
        if location + len > strlen {
            len = strlen - location
        }
        return (string as NSString).substring(with: NSRange(location: location, length: len))
    }
    
    private class func intByCGFloat(value: CGFloat) -> Int {
        return Int(round(value * 255.0))
    }
    
    private class func hexStringByCGFloat(value: CGFloat) -> String {
        let num = self.intByCGFloat(value: value)
        return NSString(format: "%02X", num) as String
    }
    
}

extension UIColor {
    
    var floatValues: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = -1, g:CGFloat = -1, b:CGFloat = -1, a:CGFloat = -1
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
    
    var intValues: (red: Int, green: Int, blue: Int, alpha: Int) {
        let fValue = self.floatValues
        return (
            UIColor.intByCGFloat(value: fValue.red),
            UIColor.intByCGFloat(value: fValue.green),
            UIColor.intByCGFloat(value: fValue.blue),
            UIColor.intByCGFloat(value: fValue.alpha)
        )
    }
}

//String:"#00ff00" -> UIColorへ
extension String {
    func toUIColor() -> UIColor {
        var rgbInt : UInt64 = 0
        let scanner = Scanner(string: self.replacingOccurrences(of:"#", with: ""))
        scanner.scanHexInt64(&rgbInt)
        let r = CGFloat((rgbInt & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgbInt & 0x00FF00) >>  8) / 255.0
        let b = CGFloat( rgbInt & 0x0000FF       ) / 255.0
        return UIColor(red:r, green:g, blue:b, alpha:1.0)
    }
}

extension UIColor {
    class func hexStr ( hexStr : NSString, alpha : CGFloat) -> UIColor {
        let alpha = alpha
        var hexStr = hexStr
        hexStr = hexStr.replacingOccurrences(of: "#", with: "") as NSString
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r, green:g, blue:b, alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.white
        }
    }
}
