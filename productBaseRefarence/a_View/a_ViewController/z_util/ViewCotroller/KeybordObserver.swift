//
//  KeybordObserver.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import UIKit

public protocol KeyboardDelegate: class {
    func keyboardWillShow(rect: CGRect)
    func keyboardWillHide(rect: CGRect)
}


/// キーボードの挙動を監視する
public final class KeyboardObserver {
    
    public private(set) var isShown = false
    
    public weak var delegate: KeyboardDelegate?
    
    public init() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        isShown = true
        
        guard let userInfo = notification.userInfo,
            let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        delegate?.keyboardWillShow(rect: keyboardRect)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        isShown = false
        
        guard let userInfo = notification.userInfo,
            let keyboardRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        delegate?.keyboardWillHide(rect: keyboardRect)
    }
}
