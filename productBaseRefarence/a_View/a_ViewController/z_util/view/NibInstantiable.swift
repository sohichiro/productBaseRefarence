//
//  NibInstantiable.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

public protocol NibInstantiatable {
    static var nibName: String { get }
    static var nibBundle: Bundle { get }
    static var nibOwner: Any? { get }
    static var nibOptions: [AnyHashable: Any]? { get }
    static var instantiateIndex: Int { get }
}

public extension NibInstantiatable where Self: NSObject {
    static var nibName: String { return className }
    static var nibBundle: Bundle { return Bundle(for: self) }
    static var nibOwner: Any? { return self }
    static var nibOptions: [AnyHashable: Any]? { return nil }
    static var instantiateIndex: Int { return 0 }
}

public extension NibInstantiatable where Self: UIView {
    static func instantiate() -> Self {
        let nib = UINib(nibName: nibName, bundle: nibBundle)
        return nib.instantiate(withOwner: nibOwner, options: nibOptions)[instantiateIndex] as! Self
    }
}

/*
 usage
 final class View: UIView, NibInstantiatable {
 }
 
 View.instantiate()
 
 // XIB名とクラス名が異なる & 2番目のView
 final class View2: UIView, NibInstantiatable {
 static var nibName: String { return "Foo" } // Foo.xib
 static var instantiateIndex: Int { return 2 }
 }
 
 View2.instantiate()
 */

public protocol EmbeddedNibInstantiatable {
    associatedtype Embedded: NibInstantiatable
}

public extension EmbeddedNibInstantiatable where Self: UIView, Embedded: UIView {
    public var embedded: Embedded { return subviews[0] as! Embedded }
    
    public func configureEmbededView() {
        let view = Embedded.instantiate()
        insertSubview(view, at: 0)
        view.fillSuperview() // 後述
    }
}

/*
 usage
 final class EmbeddedView: UIView, NibInstantiatable {
 }
 
 @IBDesignable
 final class IBEmbeddedView: UIView, EmbeddedNibInstantiatable {
    typealias Embedded = EmbeddedView
 
    #if TARGET_INTERFACE_BUILDER
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureEmbededView()
    }
    #endif
 
    override func awakeFromNib() {
        super.awakeFromNib()
        configureEmbededView()
    }
 }
 EmbeddedView.xibに置いたUIViewのCustom Classを設定
 File's Ownerの方じゃない所に置く
 または
 StoryBoard上のViewControllerにUIViewを載せて、カスタムClassを設定
 
 */

public extension UIView {
    public func fillSuperview() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = superview.translatesAutoresizingMaskIntoConstraints
        if translatesAutoresizingMaskIntoConstraints {
            autoresizingMask = [.flexibleWidth, .flexibleHeight]
            frame = superview.bounds
        } else {
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        }
    }
}
/* usage
 superView.addSubview(view)
 view.fillSuperview()
 */
