//
//  MapNavigator.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/11/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import Foundation
import MapKit

class MapNavigator: NSObject {
    private let locationManager = CLLocationManager()
    
    @discardableResult
    func launch() -> Self {
        locationManager.delegate = self
        locationManager.activityType = .fitness // 徒歩
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 最高精度
        locationManager.distanceFilter = kCLDistanceFilterNone // すべての動きを検知
        handle(CLLocationManager.authorizationStatus())
        return self
    }
    
    private func handle(_ status: CLAuthorizationStatus) {
        switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            case .denied, .restricted:
                break
            @unknown default:
                fatalError()
        }
    }
}

extension MapNavigator: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handle(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
}

