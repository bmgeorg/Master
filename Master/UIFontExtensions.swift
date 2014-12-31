//
//  UIFontExtensions.swift
//  Master
//
//  Created by Brett George on 12/31/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

extension UIFont {
    class func preferredFontSizeForTextStyle(style: String) -> CGFloat {
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(style)
        return fontDescriptor.pointSize
    }
}