//
//  FontUtil.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static var productBase: ProductBaseFont { return ProductBaseFont() }
    static var palette: FontType { return FontType() }
}

protocol ApplicationFont {
    
}

struct ProductBaseFont:ApplicationFont {
    
}

struct FontType {
    
}

extension UIFont {
    func size(of string: String, constraintedToWidth width: Double) -> CGSize {
        return (string as NSString)
        .boundingRect(with: CGSize(width: width, height: Double.greatestFiniteMagnitude),
                      options: NSStringDrawingOptions.usesLineFragmentOrigin,
                      attributes: [NSAttributedStringKey.font: self],
                      context: nil).size
    }
}
