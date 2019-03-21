//
//  UITableView+OGTableView.swift
//  OGiP
//
//  Created by Park, Chanick on 9/29/17.
//  Copyright © 2017 Dialtone. All rights reserved.
//

import UIKit

// Shared protocol to represent reusable items, e.g. table or collection view cells
protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

/**
 @desc Get dequeue with identifier as same as class name
 */
extension UITableView {
    func dequeueCell<T>(ofType type: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
    }
    
    func dequeueCell<T>(ofType type: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    // Safely dequeue a `Reusable` item
    func dequeueReusable<T: Reusable>(cellClass: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T else {
            fatalError("Misconfigured cell type, \(cellClass)!")
        }
        return cell
    }
    
    // Safely dequeue a `Reusable` item for a given index path
    func dequeueReusable<T: Reusable>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Misconfigured cell type, \(cellClass)!")
        }
        return cell
    }
}
