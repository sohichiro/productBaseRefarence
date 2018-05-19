//
//  findViewControllerExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

public extension UIApplication {
    public var topViewController : UIViewController? {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }
    
    public var topNavigationController: UINavigationController? {
        return topViewController as? UINavigationController
    }
}
//usage
//UIApplication.shared.topViewController

extension UIViewController {
    /// 現在表示している画面
    ///
    /// - Returns: 表示中の画面
    static func currentViewController() -> UIViewController? {
        if let window: UIWindow = UIApplication.shared.keyWindow,
            let vc: UIViewController = window.rootViewController {
            return UIViewController.findCurrentViewController(vc: vc)
        }
        return nil
    }
    
    /// 現在表示中の画面インスタンスを探す
    ///
    /// - Parameter vc: アプリのwindowのルート画面
    /// - Returns: current view controller
    private static func findCurrentViewController(vc: UIViewController) -> UIViewController {
        if vc.presentedViewController != nil {
            return UIViewController.findCurrentViewController(vc: vc.presentedViewController!)
        } else if vc is UISplitViewController {
            let splitVC: UISplitViewController = vc as! UISplitViewController
            if splitVC.viewControllers.count != 0 {
                return UIViewController.findCurrentViewController(vc: splitVC.viewControllers.last!)
            } else {
                return vc
            }
        } else if vc is UINavigationController {
            let naviVC: UINavigationController = vc as! UINavigationController
            if naviVC.viewControllers.count != 0 {
                return UIViewController.findCurrentViewController(vc: naviVC.topViewController!)
            } else {
                return naviVC
            }
        } else if vc is UITabBarController {
            let tabVC: UITabBarController = vc as! UITabBarController
            if tabVC.viewControllers?.count != 0 {
                return UIViewController.findCurrentViewController(vc: tabVC.selectedViewController!)
            } else {
                return tabVC
            }
        } else {
            return vc
        }
    }
}

// MARK: - そのViewが所属するViewControllerを取得
public extension UIView {
    public var viewController: UIViewController? {
        var parent: UIResponder? = self
        while parent != nil {
            parent = parent?.next
            if let viewController = parent as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
