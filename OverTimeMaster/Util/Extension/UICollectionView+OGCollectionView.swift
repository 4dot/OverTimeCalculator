//
//  UICollectionView+OGCollectionView.swift
//  OGiP
//
//  Created by Park, Chanick on 10/31/17.
//  Copyright © 2017 Dialtone. All rights reserved.
//

import UIKit


/**
 @desc Get dequeue with identifier as same as class name
 */
extension UICollectionView {
    func dequeueCell<T>(ofType type: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    // Safely dequeue a `Reusable` item for a given index path
    func dequeueReusable<T: Reusable>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Misconfigured cell type, \(cellClass)!")
        }
        return cell
    }
}
