//
//  UIApplication+.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/11/30.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import UIKit

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }

}
