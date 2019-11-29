//
//  MapView.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/11/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var store: Store<AppState, AppAction>
    var userLocation: CLLocation?
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(store)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.userTrackingMode = .follow
        mapView.showsUserLocation = true
        mapView.pointOfInterestFilter = MKPointOfInterestFilter(including: [])
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        guard let userLocation = userLocation else { return }
        uiView.setCenter(userLocation.coordinate, animated: true)
        uiView.setRegion(
            MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ),
            animated: true
        )
    }
}

extension MapView {
    class Coordinator: NSObject, CLLocationManagerDelegate {
        private let store: Store<AppState, AppAction>
        private let locationManager = CLLocationManager()
        
        init(_ store: Store<AppState, AppAction>) {
            self.store = store
            super.init()
            
            self.locationManager.delegate = self
            self.locationManager.activityType = .fitness // 徒歩
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest // 最高精度
            self.locationManager.distanceFilter = kCLDistanceFilterNone // すべての動きを検知
            self.handle(CLLocationManager.authorizationStatus())
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
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            handle(status)
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let userLocation = locations.first else { return }
            store.dispatch(.map(.updateUserLocation(location: userLocation)))
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(userLocation: nil)
    }
}

