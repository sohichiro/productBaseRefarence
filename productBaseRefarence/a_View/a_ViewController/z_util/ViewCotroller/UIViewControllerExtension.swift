//
//  UIViewControllerExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import UIKit

extension UIViewController {
    func present(animated: Bool = true, completion:(() -> Void)? = nil) {
        UIApplication.shared.topViewController?.present(self, animated: animated, completion: completion)
    }
    
    func setBackBarTitle(_ title:String = "") {
        let backButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
    }
}
