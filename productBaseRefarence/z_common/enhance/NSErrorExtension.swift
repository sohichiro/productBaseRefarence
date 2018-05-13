//
//  NSErrorExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

extension NSError {
    convenience init(code: Int = 0, message:String ) {
        self.init(domain: Bundle.main.bundleIdentifier!, code: code, userInfo: [NSLocalizedDescriptionKey:message])
    }
}
