//
//  UIApplicationExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import UIKit

extension UIApplication {
    //設定画面を開く
    func openSettingApplication(completion:((Bool) -> Void)? = nil) {
        if let url = UIApplicationOpenSettingsURLString.url {
            UIApplication.shared.open(url, options: [:], completionHandler: completion)
        }
    }
}
