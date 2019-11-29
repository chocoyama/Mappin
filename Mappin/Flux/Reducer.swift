//
//  Reducer.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/11/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import Foundation

struct Reducer<State, Action> {
    let reduce: (inout State, Action) -> Void
}

let appReducer: Reducer<AppState, AppAction> = Reducer { state, action in
    switch action {
    case .map(let action): mapReducer.reduce(&state.map, action)
    }
}

let mapReducer: Reducer<MapState, MapAction> = Reducer { state, action in
    switch action {
    case .updateUserLocation(let location):
        state.userLocation = location
    }
}
