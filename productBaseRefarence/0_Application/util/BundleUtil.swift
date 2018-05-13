//
//  BundleUtil.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

class BundleUtil {
    static func CFBundleVersion() -> String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
        return version ?? ""
    }
    
    static func CFBundleShortVersion() -> String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        return version ?? ""
    }
    
}
