//
//  HighlightableButton.swift
//  Master
//
//  Created by Brett George on 12/29/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

class HighlightableButton: UIButton {
    internal func setTitleTint() {
        setTitleColor(self.tintColor?.colorWithAlphaComponent(0.3), forState: UIControlState.Highlighted)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTitleTint()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleTint()
    }
}