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

private extension UIView {
    func overlay(on view: UIView) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func overlay(on view: UIView, insets: UIEdgeInsets) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
            ])
    }
}
