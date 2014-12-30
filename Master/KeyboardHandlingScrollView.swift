//
//  KeyboardHandlingView.swift
//  Master
//
//  Created by Brett George on 12/30/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

class KeyboardHandlingScrollView: UIScrollView, UIGestureRecognizerDelegate {
    @IBOutlet weak var keyboardDelegate: KeyboardHandlingScrollViewDelegate?
    var tapGR: UITapGestureRecognizer?
    
    internal func setup() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        addDismissKeyboardRecognizer()
    }
    
    //close keyboard tap outside of keyboard, except when tap is on enterButton (see gestureRecognizer: shouldReceiveTouch: method)
    internal func addDismissKeyboardRecognizer() {
        tapGR = UITapGestureRecognizer(target: self, action:"dismissKeyboard")
        tapGR!.cancelsTouchesInView = false
        tapGR!.delegate = self
        self.addGestureRecognizer(tapGR!)
    }
    
    override init() {
        super.init()
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    // Mark: Keyboard Handling
    
    func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            
            let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
            var contentInsets = contentInset
            contentInsets.bottom = keyboardFrame.height
            scrollIndicatorInsets = contentInsets
            contentInset = contentInsets
            
            if let view = keyboardDelegate?.getActiveField() {
                var frame = view.frame
                if let margin = keyboardDelegate?.marginAroundActiveField?() {
                    frame = CGRectInset(frame, -margin, -margin)
                }
                scrollRectToVisible(frame, animated: true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var contentInsets = contentInset
        contentInsets.bottom = 0
        scrollIndicatorInsets = contentInsets
        contentInset = contentInsets
    }
    
    //do not close keyboard when tap is on enter button
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if gestureRecognizer === tapGR {
            if keyboardDelegate?.shouldDismissKeyboardForTap? != nil {
                return keyboardDelegate!.shouldDismissKeyboardForTap!(touch)
            }
        }
        return true
    }
    
    func dismissKeyboard() {
        endEditing(true)
    }
}