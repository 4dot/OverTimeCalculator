//
//  Date+OTDate.swift
//  OG
//
//  Created by Park, Chanick on 6/30/16.
//  Copyright © 2016 Dialtone. All rights reserved.
//

import Foundation

let iso8601Full = "yyyy-MM-dd'T'HH:mm:ssXXXXX"//"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

extension Date {
    
    func yearsFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    func monthsFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    func weeksFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    func daysFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    func hoursFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    func minutesFrom(_ date: Date) -> Int{
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    func secondsFrom(_ date: Date) -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    func offsetFrom(_ date: Date) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
    func year() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: self)
        return components.year!
    }
    func month() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: self)
        return components.month!
    }
    func day() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: self)
        return components.day!
    }
    
    func timeStamp() ->TimeInterval {
        return self.timeIntervalSince1970 * 1000
    }
    
    func toDateComponent()-> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
    }
}

extension Date {
    // "M/dd/yyyy, h:mm a" AM, PM style
    func toString(_ format: String = "MM-dd-yyyy HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func asString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}
