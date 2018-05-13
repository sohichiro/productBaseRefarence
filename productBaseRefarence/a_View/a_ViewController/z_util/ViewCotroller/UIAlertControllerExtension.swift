//
//  UIAlertControllerExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    func addAction(title: String, style: UIAlertActionStyle = .default, handler:((UIAlertAction) -> Void)? = nil) -> Self {
        let okAction = UIAlertAction(title: title, style: style, handler: handler)
        addAction(okAction)
        return self
    }
    
    func addActionWithTextFields(title: String, style: UIAlertActionStyle = .default, handler: ((UIAlertAction, [UITextField]) -> Void)? = nil) -> Self {
        let okAction = UIAlertAction(title: title, style: style) { [weak self] action in
            handler?(action, self?.textFields ?? [])
        }
        addAction(okAction)
        return self
    }
    
    func configureForIPad(sourceRect: CGRect, sourceView: UIView? = nil) -> Self {
        popoverPresentationController?.sourceRect = sourceRect
        if let sourceView = UIApplication.shared.topViewController?.view {
            popoverPresentationController?.sourceView = sourceView
        }
        return self
    }
    
    func configureForIPad(barButtonItem: UIBarButtonItem) -> Self {
        popoverPresentationController?.barButtonItem = barButtonItem
        return self
    }
    
    func addTextField(handler: @escaping (UITextField) -> Void) -> Self {
        addTextField(configurationHandler: handler)
        return self
    }
    
    func show() {
        UIApplication.shared.topViewController?.present(self, animated: true, completion: nil)
    }
}
/* usage kotlin風にプロパティをつないでいける
 UIAlertController(title: "ログイン", message: "IDを入力してください", preferredStyle: .Alert)
 .addTextField { textField in
    textField.placeholder = "ID"
 }
 .addActionWithTextFields(title: "OK") { action, textFields in
    // validation
 }
 .addAction(title: "キャンセル", style: .Cancel)
 .show()
 */
