//
//  QuestionViewController.swift
//  Master
//
//  Created by Brett George on 12/23/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit
import Realm

class QuestionViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var questionTitle: UINavigationItem!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    var question: Question!
    
    let BOTTOM_MARGIN: CGFloat = 8

    @IBAction func checkAnswer() {
        if(answerField.text.uppercaseString == question.answer.uppercaseString) {
            feedbackLabel.text = "Correct!"
            feedbackLabel.textColor = UIColor.greenColor()
            RLMRealm.defaultRealm().beginWriteTransaction()
            question.solved = true
            RLMRealm.defaultRealm().commitWriteTransaction()
        } else {
            feedbackLabel.text = "Wrong!"
            feedbackLabel.textColor = UIColor.redColor()
        }
        explanationLabel.text = question.explanation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        answerField.delegate = self
        
        questionTitle.title = question.title
        questionLabel.text = question.question
        addDismissKeyboardRecognizer()
        setDefaultBottomInsets()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    // Mark: Keyboard Handling
    
    internal func setDefaultBottomInsets() {
        scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, BOTTOM_MARGIN, 0.0);
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height+BOTTOM_MARGIN, 0.0);
        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, 0.0);
        
        self.scrollView.scrollRectToVisible(answerField.frame, animated: true)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        setDefaultBottomInsets()
    }
    
    //close keyboard on return press
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        dismissKeyboard()
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
