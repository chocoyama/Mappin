//
//  CellRegisterable.swift
//  MiseryPot
//
//  Created by takyokoy on 2017/12/27.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import UIKit

protocol CellRegisterable {}
extension CellRegisterable {
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: CellRegisterable {}
extension CellRegisterable where Self: UITableViewCell {
    static func register(for tableView: UITableView, bundle: Bundle? = nil) {
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    static func dequeue(from tableView: UITableView, indexPath: IndexPath) -> Self {
        
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Self
    }
}

extension UICollectionViewCell: CellRegisterable {}
extension CellRegisterable where Self: UICollectionViewCell {
    static func register(for collectionView: UICollectionView, bundle: Bundle? = nil) {
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    static func dequeue(from collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Self
    }
}
