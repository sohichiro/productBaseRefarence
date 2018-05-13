//
//  PushNotificationManager.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import UIKit
import UserNotifications

public enum PushAuthState: Int {
    case undefined = -1
    case notDetermined = 0
    case denied
    case authorized
}

struct DeviceToken {
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
}

extension DeviceToken: CustomStringConvertible {
    public var description: String {
        return data.map { String(format: "%.2hhx", $0) }.joined()
    }
}

struct PushNotificationManager {
    
    //DeviceTokenを取得する
    static func registerPush() {
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    //ユーザーに対してPush通知の許可申請を行う
    static func allowToPushNotification(with appDelegate: AppDelegate) {
        let application = UIApplication.shared
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = appDelegate
            center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if let error = error {
                    print(error)
                    return
                }

                if granted {
                    AppSettingUtil.pushAuthState = PushAuthState.notDetermined.rawValue
                    print("Push notification is granted")
                    DispatchQueue.main.async {
                        PushNotificationManager.registerPush()
                    }
                } else {
                    print("Push notification is NOT granted")
                }
            }
        } else {
            AppSettingUtil.pushAuthState = PushAuthState.notDetermined.rawValue
            let type: UIUserNotificationType = [.alert, .badge, .sound]
            let setting = UIUserNotificationSettings(types: type, categories: nil)
            application.registerUserNotificationSettings(setting)
        }
    }

    //APNsから送信されるDeviceTokenをサーバーへ送る
    static func send(_ token: DeviceToken) {
        if AppSettingUtil.deviceToken != token.description {
            AppSettingUtil.deviceToken = token.description
            // send devicetoken to server
        }
    }

    //Push通知から
    static func handlePushNotification(_ userInfo: [AnyHashable: Any], state: UIApplicationState) {
        switch state {
        case .inactive:
            // Launch via push notification
            break
        case .active:
            break
        case .background:
            break
        }
    }
    
    //Push通知の許可状態を調べる
    static func checkRemoteNotificationStatus(handler: @escaping (_ state: PushAuthState) -> Void) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
                switch settings.authorizationStatus {
                case .authorized:
                    handler(PushAuthState.authorized)
                case .denied:
                    handler(PushAuthState.denied)
                case .notDetermined:
                    handler(PushAuthState.notDetermined)
                }
            })
        } else {
            if AppSettingUtil.pushAuthState == PushAuthState.undefined.rawValue {
                handler(PushAuthState.undefined)    //notDetermined??
                return
            }
            let settings: UIUserNotificationSettings? = UIApplication.shared.currentUserNotificationSettings
            if let raw = settings?.types.rawValue {
                if 0 == raw {
                    handler(PushAuthState.denied)
                } else {
                    handler(PushAuthState.authorized)
                }
            }
        }
    }
}
