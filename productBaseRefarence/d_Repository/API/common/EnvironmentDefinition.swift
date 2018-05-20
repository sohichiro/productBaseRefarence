//
//  EnvironmentDefinition.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/20.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

enum EnvironmentType {
    case develop
    case staging
    case qaEnv
    case release
    
    func accessDomein() -> String {
        switch self {
        case .develop:
            return ""
        case .staging:
            return ""
        case .qaEnv:
            return ""
        case .release:
            return ""
        }
    }
}

protocol EnvironmentDefinition {
    var type:EnvironmentType { get }
    var commonHeader: [String: String] { get }
    
    func url(forPath:String) -> URL
}

extension EnvironmentDefinition {
    var type: EnvironmentType { return EnvironmentType.develop }
    var commonHeader: [String: String] {
        return [:]
    }
    func url(forPath path:String) -> URL {
        return URL.init(string: type.accessDomein() + path)!
    }
}
