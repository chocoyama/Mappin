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
    var userLocation: CLLocation?
        
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

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(userLocation: nil)
    }
}

