//
//  Action.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/11/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import Foundation
import CoreLocation

enum AppAction {
    case map(MapAction)
}

enum MapAction {
    case updateUserLocation(location: CLLocation)
}
