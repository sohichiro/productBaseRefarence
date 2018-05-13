//
//  WindowSize.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import UIKit

/**
 デバイス           画面サイズ       優先されるスケール
 iPhone 4/4S       480 x 320    @2x
 iPhone 5/5s/5c    568 x 320    @2x
 iPhone 6          667 x 375    @2x
 iPhone 6 Plus     736 x 414    @3x
 iPhone X          375 x 812    @3x
 */

struct WindowSize {
    static var screenWidth: CGFloat { return UIScreen.main.bounds.width }
    static var screenHeight: CGFloat { return UIScreen.main.bounds.height }
    static var screenScale: CGFloat { return UIScreen.main.scale }
    static var screenBounds : CGRect { return UIScreen.main.bounds }
    
    static var navigationBarHeight: CGFloat { return 44 }
    static var toolBarHeight: CGFloat { return 44 }
    static var statusBarHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    static var statusBarAndNavigationBarHeight: CGFloat { return statusBarHeight + navigationBarHeight }
    
    ///iPhone4系
    static func is3_5Inche() -> Bool {
        if 480 == max(screenWidth, screenHeight) {
            return true
        }
        return false
    }
    ///iPhone5系, SE
    static func is4_0Inche() -> Bool {
        if 568 == max(screenWidth, screenHeight) {
            return true
        }
        return false
    }
    ///iPhone 6,7,8
    static func is4_7Inche() -> Bool {
        if 667 == max(screenWidth, screenHeight) {
            return true
        }
        return false
    }
    ///iPhone 6,7,8 Plus系
    static func is5_5Inche() -> Bool {
        if 736 == max(screenWidth, screenHeight) {
            return true
        }
        return false
    }
    ///iPhone X
    static func is5_8Inche() -> Bool {
        if 812 == max(screenWidth, screenHeight) {
            return true
        }
        return false
    }
}
