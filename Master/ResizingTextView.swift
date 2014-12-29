//
//  ResizingTextView.swift
//  Master
//
//  Created by Brett George on 12/28/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

class ResizingTextView: UITextView {
    var heightConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        if(heightConstraint == nil) {
            heightConstraint = findHeightConstraint()
        }
        let sizeThatFits = self.sizeThatFits(CGSizeMake(self.frame.width, CGFloat(MAXFLOAT)))
        heightConstraint.constant = sizeThatFits.height
    }
    
    internal func findHeightConstraint() -> NSLayoutConstraint! {
        for constraint in constraints() {
            if constraint.firstAttribute == NSLayoutAttribute.Height {
                return constraint as NSLayoutConstraint
            }
        }
        assertionFailure("Could not find height constraint on ResizingTextView")
        return nil
    }
}
