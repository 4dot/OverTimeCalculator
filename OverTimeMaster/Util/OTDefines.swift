//
//  OTDefines.swift
//  OverTimeMaster
//
//  Created by cpark on 4/26/19.
//  Copyright © 2019 4Dot. All rights reserved.
//

import Foundation


final class OTSetting : Singleton {
    static var shared: OTSetting {
        struct Singleton {
            static let instance = OTSetting()
        }
        return Singleton.instance
    }
    
    var TimerStatusList = [
        "WorkingTime",
        "OverTime",
        "RDO"]
}
