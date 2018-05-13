//
//  NotificationKey.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

extension Notification.Name {
    public static var sample: Notification.Name { return "sample" }
}

extension Notification.Name: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self = Notification.Name(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}
