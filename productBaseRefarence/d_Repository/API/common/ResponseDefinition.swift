//
//  ResponseDefinition.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/20.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

protocol ResponseDefinition {
    associatedtype Result
    associatedtype JSON
    
    var result: Result { get }
    
    init(json: JSON) throws
}

protocol DataResponseDefinition: ResponseDefinition {
    static var jsonKey: String { get }
}

protocol ResponseElement {
    
}

protocol SingleResponseElement: ResponseElement {
    static var singleKey: String { get }
    static func decode(from: Any) throws -> Self
}

protocol ArrayResponseElement: ResponseElement {
    static var pluralKey: String { get }
    static func decode(from: Any) throws -> [Self]
}

struct SingleResponse<T: SingleResponseElement>: DataResponseDefinition {
    public typealias Result = T
    public typealias JSON = [String: Any]
    
    public let result: Result
    
    public static var jsonKey: String {
        return T.singleKey
    }
    
    init(json: JSON) throws {
        result = try T.decode(from: json)
    }
}

struct ArrayResponse<T: ArrayResponseElement>: DataResponseDefinition {
    public typealias Result = [T]
    public typealias JSON = [[String: Any]]
    
    public let result: Result
    
    public static var jsonKey: String {
        return T.pluralKey
    }
    
    public init(json: JSON) throws {
        result = try T.decode(from: json)
    }
}

struct EmptyResponse: ResponseDefinition {
     typealias Result = Void
     typealias JSON = Any?
    
     let result: Result
    
     init(json: JSON) throws {
        result = ()
    }
}

struct CombinedResponse<T1: DataResponseDefinition, T2: DataResponseDefinition>: ResponseDefinition {
    public typealias Result = (T1.Result, T2.Result)
    public typealias JSON = [String: Any]
    
    public let result: Result
    
    public init(json: [String: Any]) throws {
        guard let t1JSON = json[T1.jsonKey] as? T1.JSON else {
            throw CombinedResponseError.keyNotFound(key: T1.jsonKey)
        }
        let t1 = try T1.init(json: t1JSON)
        
        guard let t2JSON = json[T2.jsonKey] as? T2.JSON else {
            throw CombinedResponseError.keyNotFound(key: T2.jsonKey)
        }
        let t2 = try T2.init(json: t2JSON)
        
        result = (t1.result, t2.result)
        
    }
}

public enum CombinedResponseError: Error {
    case keyNotFound(key: String)
}
