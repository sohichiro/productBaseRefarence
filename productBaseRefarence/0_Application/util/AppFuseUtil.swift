//
//  ApplicationFuseUtil.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

//一回のみしか変更できない設定
class AppFuseUtil {
    static var hasSeenTutorial:Bool {
        get { return UserDefaults.standard.bool(forKey: "has_seen_tutorial")}
        set { return UserDefaults.standard.set(true, forKey:"has_seen_tutorial")}
    }
}
