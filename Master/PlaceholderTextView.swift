//
//  PlaceholderTextView.swift
//  Master
//
//  Created by Brett George on 12/30/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

//Must be created within a storyboard/xib file
class PlaceholderTextView: ResizingTextView {
    var placeHolderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        placeHolderLabel = UILabel()
        placeHolderLabel.font = self.font
        placeHolderLabel.textColor = UIColor.lightGrayColor()
        placeHolderLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        placeHolderLabel.numberOfLines = 0
        placeHolderLabel.text = self.text
        self.text = ""
        
        let top = NSLayoutConstraint(item: placeHolderLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: placeHolderLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.LeftMargin, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: placeHolderLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: placeHolderLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.RightMargin, multiplier: 1, constant: 0)
        placeHolderLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(placeHolderLabel)
        self.addConstraint(top)
        self.addConstraint(left)
        self.addConstraint(bottom)
        self.addConstraint(right)
        self.sendSubviewToBack(placeHolderLabel)
    }
    
    override func textDidChange(notification: NSNotification) {
        super.textDidChange(notification)
        if self.text == "" {
            placeHolderLabel.alpha = 1
        } else {
            placeHolderLabel.alpha = 0
        }
    }
}