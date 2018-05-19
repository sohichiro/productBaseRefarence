//
//  ClampExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

// MARK: - 指定した範囲内に数値を収める（上限下限をカット）
extension Comparable {
    func clamped(min: Self, max:Self) -> Self {
        if self < min {
            return min
        }
        
        if self > max {
            return max
        }
        
        return self
    }
}
