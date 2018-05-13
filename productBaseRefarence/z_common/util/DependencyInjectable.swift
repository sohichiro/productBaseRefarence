//
//  DependencyInjectable.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

protocol DependencyInjectable {
    associatedtype Dependency
    static func make(with dependency:Dependency) -> Self
}
