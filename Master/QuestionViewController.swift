//
//  QuestionViewController.swift
//  Master
//
//  Created by Brett George on 12/23/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var questionTitle: UINavigationItem!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var question: Question!
    
    let ANIMATION_DURATION: NSTimeInterval = 1
    let BOTTOM_MARGIN: CGFloat = 8
    
    internal func configureView() {
        questionTitle.title = question.title
        questionLabel.text = question.question
    }
    
    @IBAction func checkAnswer() {
        if(answerField.text == question.answer) {
            explanationLabel.text = "Correct!"
            explanationLabel.textColor = UIColor.greenColor()
        } else {
            explanationLabel.text = "Wrong"
            explanationLabel.textColor = UIColor.redColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        answerField.delegate = self
        addDismissKeyboardRecognizer()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    // Mark: Keyboard Handling
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, 0.0);
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var frame = CGRectOffset(answerField.frame, 0, BOTTOM_MARGIN)
        self.scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    //close keyboard on return press
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        checkAnswer()
        return false
    }
    
    //close keyboard tap outside of keyboard, except when tap is on enterButton (see gestureRecognizer: shouldReceiveTouch: method)
    internal func addDismissKeyboardRecognizer() {
        let tapDismiss = UITapGestureRecognizer(target: self, action:"dismissKeyboard")
        tapDismiss.cancelsTouchesInView = false
        tapDismiss.delegate = self
        self.view.addGestureRecognizer(tapDismiss)
    }
    
    //do not close keyboard when tap is on enter button
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return !touch.view.isDescendantOfView(enterButton)
    }
    
    internal func dismissKeyboard() {
        answerField.resignFirstResponder()
    }
}
