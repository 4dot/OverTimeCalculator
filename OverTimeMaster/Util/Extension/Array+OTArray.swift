/**
 * Array+OTArray.swift
 * OG
 *
 * Created by Park, Chanick on 2/3/17.
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


extension Array {
    
    /**
     * @brief grouped
     * @return array
     Using:
     
     struct User { var age = 0 }
     let users: [User] = [User(age: 2), User(age: 4), User(age: 5), User(age: 5), User(age: 2)]
     let groupedUser = users.groupBy { $0.age }
     print(groupedUser)
     */
    func grouped<T: Hashable>(_ groupClosure: (Element) -> T) -> [[Element]] {
        var groups = [[Element]]()
        
        for element in self {
            let key = groupClosure(element)
            var active = Int()
            var isNewGroup = true
            var array = [Element]()
            
            for (index, group) in groups.enumerated() {
                let firstKey = groupClosure(group[0])
                if firstKey == key {
                    array = group
                    active = index
                    isNewGroup = false
                    break
                }
            }
            
            array.append(element)
            
            if isNewGroup {
                groups.append(array)
            } else {
                groups.remove(at: active)
                groups.insert(array, at: active)
            }
        }
        
        return groups
    }
    /**
     * @brief groupBy
     * @return dictionary
     Using :
     
     let numbers = [1, 2, 3, 4, 5, 6]
     let groupedNumbers = numbers.grouped(by: { (number: Int) -> String in
        if number % 2 == 1 {
            return "odd"
        } else {
            return "even"
        }
     })
     result: ["odd": [1, 3, 5], "even": [2, 4, 6]]
     */
    func groupBy<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
    
    /**
     * @desc remove duplicate 
     */
    func filterDuplicates(_ includeElement: @escaping (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element] {
        var results = [Element]()
        
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        
        return results
    }
    
    func getElementBy(_ index: Int) ->Element? {
        return self[safe: index]
    }
    
    /**
     * @desc safe accee with index
     * @param index
     * @return Element optional
     */
    subscript (safe index: Index) -> Element? {
        return (index >= 0 && index < count) ? self[index] : nil
    }
}

extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
    
    var duplicates: [Element] {
        let groups = Dictionary(grouping: self, by: {$0})
        let duplicateGroups = groups.filter {$1.count > 1}
        let duplicates = Array(duplicateGroups.keys)
        return duplicates
    }
}
