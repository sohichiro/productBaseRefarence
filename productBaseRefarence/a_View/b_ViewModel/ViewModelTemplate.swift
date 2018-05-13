//
//  ViewModelTemplate.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

protocol ViewModelInputs {}
protocol ViewModelOutputs {}

protocol InputOutpuViewModelType {
    associatedtype Inputs: ViewModelInputs
    associatedtype Outputs: ViewModelOutputs
    
    var outputs: Outputs! { get }
    init(inputs: ViewModelInputs)
}
