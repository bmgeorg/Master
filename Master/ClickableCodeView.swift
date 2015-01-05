//
//  ClickableCodeView.swift
//  Master
//
//  Created by Brett George on 1/4/15.
//  Copyright (c) 2015 Brett George. All rights reserved.
//

import UIKit

class ClickableCodeView: CodeView {
    var clickDelegate: ClickableCodeViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGR = UITapGestureRecognizer(target: self, action: "textTapped:")
        codeTextView.addGestureRecognizer(tapGR)
    }
    
    func textTapped(gesture: UITapGestureRecognizer) {
        var location = gesture.locationInView(codeTextView)
        location.x -= codeTextView.textContainerInset.left
        location.y -= codeTextView.textContainerInset.top
        
        //Find the character that's been tapped
        let characterIndex = codeTextView.layoutManager.characterIndexForPoint(location, inTextContainer: codeTextView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        if characterIndex < codeTextView.textStorage.length {
            var range = NSMakeRange(0, 0)
            let attributes = codeTextView.textStorage.attributesAtIndex(characterIndex, longestEffectiveRange: &range, inRange: NSMakeRange(0, codeTextView.textStorage.length))
            clickDelegate?.textWasClickedInRange(range, withAttributes:attributes)
        }
    }
}

protocol ClickableCodeViewDelegate {
    func textWasClickedInRange(range: NSRange, withAttributes attributes: [NSObject: AnyObject])
}