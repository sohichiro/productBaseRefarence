//
//  ApplicationSettingUtil.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

class AppSettingUtil {
    //push通知用変数
    static var deviceToken: String {
        get { return UserDefaults.standard.string(forKey: "deviceToken") ?? "" }
        set { return UserDefaults.standard.set(newValue, forKey:"deviceToken")}
    }
    
    //前回起動したバージョン
    static var previousLaunchAppVersion: String {
        get { return UserDefaults.standard.string(forKey: "previousLaunchAppVersion") ?? "" }
        set { return UserDefaults.standard.set(newValue, forKey:"previousLaunchAppVersion")}
    }
    
    //プッシュ通知の承認状態
    static var pushAuthState: Int {
        get { return UserDefaults.standard.integer(forKey: "pushAuthState")}
        set { return UserDefaults.standard.set(newValue, forKey:"pushAuthState")}
    }
}
