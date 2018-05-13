//
//  AppliableExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

protocol Appliable { }


// MARK: - 一括でプロパティを設定する
extension Appliable {
    @discardableResult
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}
/* usage
 let view = UIView().apply {
 $0.backgroundColor = .red
 $0.frame = .init(x: 0, y: 0, width: 200, height: 200)
 }
 */

extension NSObject : Appliable {}

protocol Runnable { }

extension Runnable {
    @discardableResult
    public func run<T>(closure:(Self) -> T) -> T {
        return closure(self)
    }
}

extension NSObject : Runnable { }
