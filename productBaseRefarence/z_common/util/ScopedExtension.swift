//
//  ScopedExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

struct ProductBaseExtension<Base> {
    let base : Base
    
    init(_ base: Base) {
        self.base = base
    }
}

protocol ProductBaseExtensionCompatible {
    associatedtype Compatible
    static var productBase: ProductBaseExtension<Compatible>.Type { get }
    var productBase: ProductBaseExtension<Compatible> { get }
}

extension ProductBaseExtensionCompatible {
    static var productBase: ProductBaseExtension<Self>.Type {
        return ProductBaseExtension<Self>.self
    }
    
    var productBase: ProductBaseExtension<Self> {
        return ProductBaseExtension(self)
    }
}
