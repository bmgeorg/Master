//
//  StringExtensions.swift
//  Master
//
//  Created by Brett George on 12/31/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

extension String {
    mutating func replaceAll(target: String, with replacement: String) {
        var currInd = startIndex
        // check first that the first character of search string exists
        if contains(self, first(target)!) {
            // if so set this as the place to start searching
            currInd = find(self, first(target)!)!
            var i = distance(startIndex, currInd)
            while i<=countElements(self)-countElements(target) {
                if self[advance(startIndex, i)..<advance(startIndex, i+countElements(target))] == target {
                    let range = Range(start: advance(startIndex, i), end: advance(startIndex, i+countElements(target)))
                    self.replaceRange(range, with: replacement)
                    i = i+countElements(replacement)
                } else {
                    i++
                }
            }
        }
    }
    
    func charAt(pos: Int) -> Character {
        return Array(self)[pos]
    }
    
    static func fromCharArray(array: [Character]) -> String {
        var result = ""
        //This is stupid, and is much costlier than it should be, but I can't set string characters directly.
        //Fucking swift strings
        for char in array {
            result.append(char)
        }
        return result
    }
    
    //end is exclusive
    static func fromCharArray(array: [Character], start: Int, end: Int) -> String {
        assert(start <= end, "start index greater than end index in fromCharArray.")
        assert(start >= 0, "start index less than 0 in fromCharArray.")
        assert(end <= array.count, "end index greater than array count in fromCharArray.")
        
        var result = ""
        //This is stupid, and is much costlier than it should be, but I can't set string characters directly.
        for i in start..<end {
            result.append(array[i])
        }
        return result
    }
}
