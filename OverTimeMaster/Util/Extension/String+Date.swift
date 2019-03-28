/**
 * String+Date.swift
 * OG
 *
 * Created by Park, Chanick on 2/17/17.
 * Copyright (c) 2017 Options Group Inc
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import UIKit


// Date Util
extension String {
    // to Date
    func toDate(_ format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        if self.isEmpty {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? nil
    }
    
    /**
     * @desc get working year
     * @return float value
     */
    func workYears() -> CGFloat {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        var date = dateFormatter.date(from: self)
        if date == nil {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            date = dateFormatter.date(from: self)
        }
        if date == nil {
            dateFormatter.dateFormat = "MM/yy"
            date = dateFormatter.date(from: self)
        }
        if date == nil {
            dateFormatter.dateFormat = "MM/yyyy"
            date = dateFormatter.date(from: self)
        }
        
        if date != nil {
            let diffDate = Date().monthsFrom(date!)
            return CGFloat(diffDate) / 12.0
        }
        return 0
    }
    
    // ex. "  this is the answer   " -> "this is the answer"
    public func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
