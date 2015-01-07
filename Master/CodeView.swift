//
//  CodeView.swift
//  Master
//
//  Created by Brett George on 1/3/15.
//  Copyright (c) 2015 Brett George. All rights reserved.
//

import UIKit

@IBDesignable class CodeView: UIView {
    var view: UIView!
    
    @IBOutlet var lineNumberTextView: UITextView!
    @IBOutlet var codeTextView: UITextView!
    
    var font: UIFont!
    
    internal func setup() {
        view = loadViewFromNib()
        
        view.frame = self.bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        addSubview(view)
        
        //set default font
        let bodySize = UIFont.preferredFontSizeForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "Menlo-Regular", size: bodySize)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    internal func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CodeView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Apple Bug in UITextView - See below
        lineNumberTextView.selectable = true
        codeTextView.selectable = true
        
        setLineNumbers()
        lineNumberTextView.font = font
        
        //Apple Bug in UITextView - See below
        lineNumberTextView.selectable = false
        codeTextView.selectable = false
    }
    
    internal func setLineNumbers() {
        var count = 2
        let string = codeTextView.text
        lineNumberTextView.text = "1"
        
        //to prevent adding a new line to the last line
        var delayedAppend = false
        codeTextView.layoutManager.enumerateLineFragmentsForGlyphRange(NSMakeRange(0, codeTextView.text.utf16Count), usingBlock: {rect, usedRect, textContainer, glyphRange, stop in
            if delayedAppend {
                self.lineNumberTextView.text.append("\n")
                delayedAppend = false
            }
            let last = advance(string.startIndex, glyphRange.location + glyphRange.length - 1)
            if(string[last] == "\n") {
                self.lineNumberTextView.text.append("\n\(count++)")
            } else {
                //We should still append a newline, but only if there are subsequent lines.
                //So delay append to next call.
                delayedAppend = true
            }
            
        })
    }
    
    func setText(text: NSAttributedString) {
        /* Apple Bug in UITextView:
        After changing text in non-selectable, non-editable text view, the font of the text view is reset to some other (unknown to me) font. (I don't think the new font is even the same one as in storyboard.) To avoid this bug, we make the text view selectable just while the changes are being made. This prevents the font change. Thanks Apple. */
        lineNumberTextView.selectable = true
        codeTextView.selectable = true
        
        codeTextView.attributedText = text
        setLineNumbers()
        
        //Apple Bug in UITextView - See Above
        lineNumberTextView.selectable = false
        codeTextView.selectable = false
    }
    
    func defaultFont() -> UIFont {
        return font
    }
}
