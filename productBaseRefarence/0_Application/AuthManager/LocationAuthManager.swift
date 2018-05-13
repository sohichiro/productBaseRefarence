//
//  LocationAuthManager.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/13.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation

import UIKit
import UserNotifications
import CoreLocation

class LocationUtility: NSObject {
    
    /**
     *  位置情報取得の許諾ステータス
     *
     *  - notDetermined:  何もしていない
     *  - restricted:  ユーザーより拒否されている
     *  - denied:  完全拒否
     *  - authorized:  許可
     */
    enum LocationUtilityAuthState: Int {
        case notDetermined
        case restricted
        case denied
        case authorized
    }
    
    /* ブロックの型を明記 */
    typealias SearchHander = ( (_ location: CLLocation?, _ appState: LocationUtilityAuthState) -> Void )
    static var shared: LocationUtility = LocationUtility()
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    fileprivate var appState: LocationUtilityAuthState = .notDetermined
    fileprivate var handler: SearchHander?
    
    /**
     *  位置情報取得許可を行う
     */
    func requestLocationAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    /**
     *  位置情報の取得許可を行い、位置情報を検索する
     *  ハンドラーは、位置情報取得時に返すために使用
     *
     *  - Parameter handler: 結果を受け取るハンドラ
     */
    func requestLocationAuthorization(handler: SearchHander?) {
        if self.handler != nil {
            self.handler = nil
        }
        self.handler = handler
        switch self.appState {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            self.handler?(nil, self.appState)
        case .authorized:
            self.locationManager.startUpdatingLocation()
        }
    }
    
    /**
     *  位置情報検索を行う
     *
     *  - Parameter handler: 結果を受け取るハンドラ
     */
    func searchLocation(handler:@escaping SearchHander) {
        if self.handler != nil {
            self.handler = nil
        }
        self.handler = handler
        self.locationManager.startUpdatingLocation()
    }
    
    /**
     *  位置情報検索を停止する
     */
    func stopSearchLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    fileprivate override init() {
        super.init()
        self.locationManager.delegate = self
        /**
         *  kCLLocationAccuracy
         *
         *  What usable with this app is kCLLocationAccuracyKilometer or kCLLocationAccuracyHundredMeters
         *
         *  kCLLocationAccuracyKilometer is accurate to the nearest kilometer.
         *  kCLLocationAccuracyHundredMeters is accurate to within one hundred meters.
         */
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.appState = self.checkAuthorization()
    }
    
    /**
     *  位置情報取得許可を調査
     */
    fileprivate func checkAuthorization() -> LocationUtilityAuthState {
        let state: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        return self.getStatus(state: state)
    }
    
    /**
     *  位置情報許可状態をアプリ内で使う状態列挙隊に変換して返す
     */
    fileprivate func getStatus(state: CLAuthorizationStatus) -> LocationUtilityAuthState {
        var appState: LocationUtilityAuthState
        switch state {
        case .notDetermined:
            appState = .notDetermined
        case .restricted:
            appState = .restricted
        case .denied:
            appState = .denied
        case .authorizedWhenInUse, .authorizedAlways:
            appState = .authorized
        }
        return appState
    }
    
}

/**
 *  位置情報取得のための拡張
 */
extension LocationUtility: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.appState = self.getStatus(state: status)
        if self.handler != nil {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // TODO: One more?
        self.stopSearchLocation()
        if locations.count != 0 {
            self.handler?(locations.first, self.appState)
        }
    }
    
}
