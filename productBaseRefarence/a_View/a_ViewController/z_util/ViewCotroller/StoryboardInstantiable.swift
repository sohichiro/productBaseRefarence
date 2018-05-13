//
//  StoryboardInstantiable.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardInstantiateType {
    case initial
    case identifier(String)
}

protocol StoryboardInstantiatable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle { get }
    static var instantiateType: StoryboardInstantiateType { get }
}

extension StoryboardInstantiatable where Self: NSObject {
    static var storyboardName: String {
        return className
    }
    
    static var storyboardBundle: Bundle {
        return Bundle(for: self)
    }
    
    private static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: storyboardBundle)
    }
    
    static var instantiateType: StoryboardInstantiateType {
        return .identifier(className)
    }
}

extension StoryboardInstantiatable where Self: UIViewController {
    static func instantiate() -> Self {
        switch instantiateType {
        case .initial:
            return storyboard.instantiateInitialViewController() as! Self
        case .identifier(let identifier):
            return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        }
    }
}

/* usage
 // a)クラス名とStoryboard名、Storyboard IDが同じ
 final class ViewController: UIViewController, StoryboardInstantiatable {
 }
 
 ViewController.instantiate()
 
 // b)Is Initial View Controllerにチェックを入れている & クラス名とStoryboard名が同じ
 final class InitialViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType {
        return .initial
    }
 }
 
 InitialViewController.instantiate()
 
 */
