//
//  Singleton.swift
//  OGiPClient
//
//  Created by Park, Chanick on 2/20/18.
//  Copyright © 2018 Chanick Park. All rights reserved.
//

import Foundation


protocol Singleton {
    static var shared: Self { get }
}

