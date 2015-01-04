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
    
    internal func setup() {
        view = loadViewFromNib()
        
        view.frame = self.bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        addSubview(view)
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
        self.setLineNumbers()
        let bodySize = UIFont.preferredFontSizeForTextStyle(UIFontTextStyleBody)
        let theFont = UIFont(name: "Menlo-Regular", size: bodySize)
        lineNumberTextView.font = theFont!
        codeTextView.font = theFont!
    }
    
    internal func setLineNumbers() {
        /* Apple Bug in UITextView:
        After changing text in non-selectable, non-editable text view, the font of the text view is reset to some other (unknown to me) font. (I don't think the new font is even the same one as in storyboard.) To avoid this bug, we make the text view selectable just while the changes are being made. This prevents the font change. Thanks Apple. */
        lineNumberTextView.selectable = true
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
    
    func setText(text: String) {
        codeTextView.text = text
        /* Apple Bug in UITextView:
        After changing text in non-selectable, non-editable text view, the font of the text view is reset to some other (unknown to me) font. (I don't think the new font is even the same one as in storyboard.) To avoid this bug, we make the text view selectable just while the changes are being made. This prevents the font change. Thanks Apple. */
        lineNumberTextView.selectable = true
        setLineNumbers()
        lineNumberTextView.selectable = false
    }
}
