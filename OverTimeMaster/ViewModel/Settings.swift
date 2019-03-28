//
//  Settings.swift
//  OverTimeMaster
//
//  Created by cpark on 3/25/19.
//  Copyright © 2019 4Dot. All rights reserved.
//

import Foundation




struct Settings {
    // MARK: - calendar options
    
    static let dayFormat: String = "yyyy MM dd"
    
    // calendar start, end date
    static let calendarStartDate = "2017 01 01".toDate("yyyy MM dd")!
    static let calendarEndDate = "2030 01 01".toDate("yyyy MM dd")!
    
    static let numOfRowsInCalendar = 6
    static let maxNumOfRandomEvent = 100
}
