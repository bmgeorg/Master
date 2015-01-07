//
//  TextParser.swift
//  Master
//
//  Created by Brett George on 12/31/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

class TextAttributor {
    
    class func getAttributorForTag(tag:String) -> ((string: NSMutableAttributedString, range: NSRange) -> ())? {
        let bodySize = UIFont.preferredFontSizeForTextStyle(UIFontTextStyleBody)
        if tag == "code" {
            return {string, range in
                string.addAttribute(NSFontAttributeName, value: UIFont(name: "Menlo-Regular", size: bodySize)!, range: range)
            }
        }
        if tag == "answer" {
            return {string, range in
                string.addAttribute("answer", value: true, range: range)
            }
        }
        return nil
    }
    
    class func attributeText(var str: String, defaultFont: UIFont) -> NSAttributedString {
        var result = NSMutableAttributedString(string: str)
        result.addAttribute(NSFontAttributeName, value: defaultFont, range: NSMakeRange(0, result.length))
        
        let charArray = Array(str)
        var i = 0
        var tagStack = [(String, Int)]()
        //apply all attributes front to back
        while i < charArray.count {
            if let token = findNextToken(charArray, startIndex: i) {
                let tag = tagFromToken(charArray, token: token)
                //If closing, must match tag from tagStack
                if getAttributorForTag(tag) != nil {
                    if charArray[token.start+1] == "/" {
                        assert(tagStack.last != nil, "Closed tag without open tag in attributeText.")
                        assert(tag == tagStack.last!.0, "Closed tag does not match opening tag in attributeText.")
                        let begin = tagStack.removeLast().1
                        let attributor = getAttributorForTag(tag)
                        attributor!(string: result, range: NSMakeRange(begin, token.start-begin))
                    } else  {
                        tagStack.append((tag, token.end))
                    }
                }
                i = token.end + 1
            } else {
                break
            }
        }
        assert(tagStack.isEmpty, "Unclosed tags on stack after parsing in attributeText.")
        //remove all tags back to front
        i = charArray.count - 1
        while i >= 0 {
            if let token = findPreviousToken(charArray, startIndex: i) {
                let tag = tagFromToken(charArray, token: token)
                if getAttributorForTag(tag) != nil {
                    result.replaceCharactersInRange(NSMakeRange(token.start, token.end-token.start), withString: "")
                }
                i = token.start - 1
            } else {
                break
            }
        }
        return result
    }
    
    internal class func tagFromToken(arr: [Character], token: (start: Int, end: Int)) -> String {
        if arr[token.start+1] == "/" {
            return String.fromCharArray(arr, start: token.start+2, end: token.end-1)
        } else {
            return String.fromCharArray(arr, start: token.start+1, end: token.end-1)
        }
    }
    
    internal class func findNextToken(arr: [Character], startIndex: Int) -> (start: Int, end: Int)? {
        assert(startIndex < arr.count, "start index is greater than or equal to array count in findNextToken.")
        assert(startIndex >= 0, "start index is less than 0 in findNextToken.")
        var i = startIndex
        var start: Int?
        var end: Int?
        while i < arr.count {
            if arr[i] == "<" {
                start = i
            }
            if arr[i] == ">"  && start != nil {
                end = i + 1
                return (start!, end!)
            }
            i++
        }
        return nil
    }
    
    //startIndex is the first letter to check, working backward
    internal class func findPreviousToken(arr: [Character], startIndex: Int) -> (start: Int, end: Int)? {
        assert(startIndex < arr.count, "start index is greater than or equal to array count in findPreviousToken.")
        assert(startIndex >= 0, "start index is less than 0 in findPreviousToken.")
        var i = startIndex
        var start: Int?
        var end: Int?
        while i >= 0 {
            if arr[i] == ">" {
                end = i + 1
            }
            if arr[i] == "<"  && end != nil {
                start = i
                return (start!, end!)
            }
            i--
        }
        return nil
    }
}