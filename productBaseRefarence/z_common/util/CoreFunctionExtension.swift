//
//  CoreFunctionExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

import Foundation

func print(_ message: String, filename: String = #file, line: Int = #line, function: String = #function) {
    #if DEBUG
    Swift.print("\((filename as NSString).lastPathComponent):\(line) \(function):\r\(message)")
    #endif
}
