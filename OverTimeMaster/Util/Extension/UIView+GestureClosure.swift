//
//  UIView+GestureClosure.swift
//  OGiP
//
//  Created by Park, Chanick on 11/9/17.
//  Copyright © 2017 Dialtone. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "AssociatedObjectKey_viewTap"
        static var longTapGestureRecognizer = "AssociatedObjectKey_viewLongTap"
        static var panGestureRecognizer = "AssociatedObjectKey_viewPan"
    }
    
    fileprivate typealias Handler = ((_ sender: UIGestureRecognizer) -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Handler? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Handler
            return tapGestureRecognizerActionInstance
        }
    }
    
    fileprivate var longTapGestureRecognizerAction: Handler? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.longTapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let longTapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.longTapGestureRecognizer) as? Handler
            return longTapGestureRecognizerActionInstance
        }
    }
    
    fileprivate var panGestureRecognizerAction: Handler? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.panGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let panGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.panGestureRecognizer) as? Handler
            return panGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: ((_ sender: UIGestureRecognizer) -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    public func addLongTapGestureRecognizer(action: ((_ sender: UIGestureRecognizer) -> Void)?) {
        self.isUserInteractionEnabled = true
        self.longTapGestureRecognizerAction = action
        let longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTapGesture))
        self.addGestureRecognizer(longTapGestureRecognizer)
    }
    
    public func addPanGestureRecognizer(action: ((_ sender: UIGestureRecognizer) -> Void)?) {
        self.isUserInteractionEnabled = true
        self.panGestureRecognizerAction = action
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(_ sender: UIGestureRecognizer) {
        if let handler = self.tapGestureRecognizerAction {
            handler?(sender)
        } else {
            print("no action")
        }
    }
    
    @objc fileprivate func handleLongTapGesture(_ sender: UIGestureRecognizer) {
        if let handler = self.longTapGestureRecognizerAction {
            handler?(sender)
        } else {
            print("no action")
        }
    }
    
    @objc fileprivate func handlePanGesture(_ sender: UIGestureRecognizer) {
        if let handler = self.panGestureRecognizerAction {
            handler?(sender)
        } else {
            print("no action")
        }
    }
}
