//
//  EnumEnumerable.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

/*
 Enumのcaseを配列で返すProtocol
 （Enumの中身はAssociated Valueを持たないもの）
 enum OtherType: EnumEnumerable {
 case hoge(String)
 case fuga(Int)
 }
 みたいな
 */

//Swift 4.2から、CaseIterableに適応したenumであれば、.allCasesが使える
protocol EnumEnumerable {
    associatedtype Case = Self
}

extension EnumEnumerable where Case: Hashable {
    private static var iterator:AnyIterator<Case> {
        var i = 0
        return AnyIterator {
            defer { i += 1 }
            
            let next = withUnsafePointer(to: &i) {
                UnsafeRawPointer($0).assumingMemoryBound(to: Case.self).pointee
            }
            return next.hashValue == i ? next : nil
        }
    }
    
    internal static func enumerate() -> EnumeratedSequence<AnySequence<Case>> {
        return AnySequence(self.iterator).enumerated()
    }
    
    @available(swift, deprecated:4.1)
    internal static var allCases: [Case] {
        return Array(self.iterator)
    }
    
    internal static var count:Int {
        return self.allCases.count
    }
}
