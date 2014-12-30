//
//  KeyboardHandlingViewDelegate.swift
//  Master
//
//  Created by Brett George on 12/30/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

@objc protocol KeyboardHandlingScrollViewDelegate {
    //Scrolls active field to visible when keyboard appears
    func getActiveField() -> UIView?
    optional func shouldDismissKeyboardForTap(touch: UITouch) -> Bool
    //defaults to no padding
    optional func marginAroundActiveField() -> CGFloat
}