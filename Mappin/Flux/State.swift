//
//  State.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/11/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import Foundation
import CoreLocation

struct AppState {
    var map: MapState
}

struct MapState {
    var userLocation: CLLocation?
}
