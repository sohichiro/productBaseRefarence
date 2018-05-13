//
//  OptionalThrowExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

infix operator ???


/// ???でOptionalをErrorとしてThrowする
///
/// - Parameters:
///   - lhs:オプショナルの変数
///   - error:エラーがあった際のクロージャ
/// - Returns:正常に処理された結果
/// - Throws: エラー内容
public func ??? <T>(lhs: T?, error: @autoclosure() -> Error) throws -> T {
    guard let value = lhs else { throw error() }
    return value
}
/* usage
 let value: String? = nil
 
 struct OptionalError: Error {}
 
 do {
    let v = try value ??? OptionalError()
    print(v) // unreachable
 } catch {
    print(error) //=> OptionalError
 }
 */


/// Dictionaryの値取得時にkeyがなければErrorをThrowする
public struct DictionaryTryValueError: Error {
    public init() {}
}

public extension Dictionary {
    func tryValue(forKey key: Key, error: Error = DictionaryTryValueError()) throws -> Value {
        guard let value = self[key] else { throw error }
        return value
    }
}

/* usage
 var dictionary: [String: Int] = [:]
 do {
    let value = try dictionary.tryValue(forKey: "foo")
    print(value) // unreachable
 } catch {
    print(error) //=> DictionaryTryValueError
 }
 */
