//
//  TimerStatus.swift
//  OverTimeMaster
//
//  Created by cpark on 4/16/19.
//  Copyright © 2019 4Dot. All rights reserved.
//

import Foundation


//enum TimerStatus : String {
//    case OverTime = "Overtime"
//    case RDO = "RDO"
//    case Extra = "Extra"
//}

typealias TimerStatus = String


class TimerStatusManager {
    var status: [TimerStatus] = []
    
    
    
    // MARK: - init
    init(_ status: [TimerStatus]) {
        self.status = status
    }
    
    // MARK: - public
    
    func addStatus(_ status: TimerStatus) {
        if !self.status.contains(status) {
            self.status.append(status)
        }
    }
    
    func removeStatus(_ status: TimerStatus) {
        if let idx = self.status.firstIndex(of: status) {
            self.status.remove(at: idx)
        }
    }
    
    func isExistStatus(_ status: TimerStatus) -> Bool {
        return self.status.firstIndex(of: status) != nil ? true : false
    }
}
