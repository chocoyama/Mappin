//
//  LocationManager.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/11/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var store: Store<AppState, AppAction>?
    
    @discardableResult
    func initialize(_ store: Store<AppState, AppAction>) -> Self {
        self.store = store
        self.locationManager.delegate = self
        self.locationManager.activityType = .fitness // 徒歩
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest // 最高精度
        self.locationManager.distanceFilter = kCLDistanceFilterNone // すべての動きを検知
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

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handle(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }
        store?.dispatch(action: .map(.updateUserLocation(location: userLocation)))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
