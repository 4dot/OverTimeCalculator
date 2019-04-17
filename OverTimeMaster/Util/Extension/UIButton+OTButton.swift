//
//  UIButton+OTButton.swift
//  OGiP
//
//  Created by Park, Chanick on 10/30/17.
//  Copyright © 2017 Dialtone. All rights reserved.
//
// https://gist.github.com/ferbass/eb1f08d72e323fd818dfb03a071f419e
//
import UIKit

/// Adding a closure as target to a UIButton
extension UIButton {
    private func actionHandleBlock(action:(() -> Void)? = nil) {
        struct __ {
            static var action :(() -> Void)?
        }
        if action != nil {
            __.action = action
        } else {
            __.action?()
        }
    }
    
    @objc private func triggerActionHandleBlock() {
        self.actionHandleBlock()
    }
    
    func actionHandle(controlEvents control :UIControl.Event, ForAction action:@escaping () -> Void) {
        self.actionHandleBlock(action: action)
        self.addTarget(self, action: #selector(UIButton.triggerActionHandleBlock), for: control)
    }
}


