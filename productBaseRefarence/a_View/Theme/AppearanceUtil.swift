//
//  AppearanceUtil.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

struct AppearanceUtil {
    static func setUp() {
        // Icon color of NavigationBar
        UINavigationBar.appearance().tintColor = UIColor.productBase.tint
        
        // Text color of NavigationBar
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.productBase.primaryText]
        
        // Text color (UIButton & UIAlertView & ...)
        UIView.appearance().tintColor = UIColor.productBase.tint
    }
}
