//
//  SideEffect.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/11/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import Foundation
import Combine

protocol Effect {
    associatedtype Action
    func mapToAction() -> AnyPublisher<Action, Never>
}

enum SideEffect: Effect {
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        }
    }
}
