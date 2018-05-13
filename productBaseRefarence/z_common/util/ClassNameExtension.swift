//
//  ClassNameExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }
    
    public var className:String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol { }

// usage
//UIView.className
//UILabel().className
