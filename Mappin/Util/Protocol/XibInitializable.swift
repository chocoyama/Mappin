//
//  XibInitializable.swift
//  MiseryPot
//
//  Created by takyokoy on 2017/12/26.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import UIKit

/**
 以下のイニシャライザを実装
 ```
 required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setXibView()
 }
 
 override init(frame: CGRect) {
    super.init(frame: frame)
    setXibView()
 }
 ```
 */
protocol XibInitializable: class {}
extension XibInitializable where Self: UIView {
    func setXibView() {
        let nib = UINib(nibName: String(describing: Self.self), bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        xibView.backgroundColor = .clear
        self.insertSubview(xibView, at: 0)
        xibView.overlay(on: self)
    }
    
    init() {
        self.init(frame: .zero)
    }
    
}
