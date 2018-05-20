//
//  EndpointDefinition.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/20.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import APIKit

protocol EndpointDefinision {
    associatedtype Response: ResponseDefinition
    associatedtype Environment: EnvironmentDefinition
    
    var path: String { get }
    var environment: Environment { get }
    var parameters: [String: Any] { get }
    var header: [String: String] { get }
    var method: HTTPMethod { get }
}
