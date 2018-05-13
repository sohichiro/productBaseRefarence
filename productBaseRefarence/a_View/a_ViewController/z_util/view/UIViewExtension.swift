//
//  UIViewExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// subViewを全て削除する
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
