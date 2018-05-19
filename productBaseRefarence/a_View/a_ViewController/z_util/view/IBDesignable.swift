//
//  IBDesignable.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import UIKit

/// 角丸
protocol IBRoundable: class {
    var cornerRadius: CGFloat { get set }
    var masksToBounds: Bool { get set }
}

/// 枠線
protocol IBBorderable: class {
    var borderColor: UIColor { get set }
    var borderWidth: CGFloat { get set }
}

/// 円形
protocol Circlable: class {}
//@IBDesignable
//class IBDesignableView: UIView, IBRoundable, IBBorderable {
//    @IBInspectable var borderColor: UIColor = .black {
//        didSet { layer.borderColor = borderColor.cgColor }
//    }
//    @IBInspectable var borderWidth: CGFloat = 0.0 {
//        didSet { layer.borderWidth = borderWidth }
//    }
//    @IBInspectable var cornerRadius: CGFloat = 5.0 {
//        didSet { layer.cornerRadius = cornerRadius }
//    }
//    @IBInspectable var masksToBounds: Bool = true {
//        didSet { layer.masksToBounds = masksToBounds }
//    }
//}

@IBDesignable
extension UIView : IBRoundable {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = cornerRadius }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get { return self.layer.masksToBounds }
        set { self.layer.masksToBounds = masksToBounds }
    }
}

@IBDesignable
extension UIView : IBBorderable {
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = borderWidth }
    }
}

extension Circlable where Self : UIView {
     func layoutSubviews() {
        self.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2.0
        clipsToBounds = true
    }
}
