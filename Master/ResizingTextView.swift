//
//  ResizingTextView.swift
//  Master
//
//  Created by Brett George on 12/28/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

class ResizingTextView: UITextView {
    lazy var heightConstraint: NSLayoutConstraint! = {
        for constraint in self.constraints() {
            if constraint.firstAttribute == NSLayoutAttribute.Height {
                return constraint as NSLayoutConstraint
            }
        }
        assertionFailure("Could not find height constraint on ResizingTextView")
        return nil
    }()
    
    internal func listenToTextChanges() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("textDidChange:"), name:UITextViewTextDidChangeNotification, object: self);
    }
    
    internal func commonInit() {
        listenToTextChanges()
        self.scrollEnabled = false
        self.bounces = false
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    override func layoutSubviews() {
        let sizeThatFits = self.sizeThatFits(CGSizeMake(self.frame.width, CGFloat(MAXFLOAT)))
        heightConstraint.constant = sizeThatFits.height
    }
    
    func textDidChange(notification: NSNotification) {
        layoutSubviews()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
}
