//
//  Observable.swift
//  OverTimeMaster
//
//  Created by cpark on 3/25/19.
//  Copyright © 2019 4Dot. All rights reserved.
//

import Foundation


class Observable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func fire() {
        listener?(value)
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
