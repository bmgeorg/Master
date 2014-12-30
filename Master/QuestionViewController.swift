//
//  QuestionViewController.swift
//  Master
//
//  Created by Brett George on 12/23/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit
import Realm

class QuestionViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var answerTextView: ResizingTextView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var explanationView: UIView!
    @IBOutlet weak var explanationHeightConstraint: NSLayoutConstraint!
    
    var question: Question!
    var test: Test!
    
    let UNBOUNDED_HEIGHT: CGFloat = 100000000
    
    @IBAction func checkAnswer() {
        enterButton.enabled = false
        answerTextView.editable = false
        answerTextView.textColor = UIColor.grayColor()
        if(test.submitAnswer(answerTextView.text)) {
            feedbackLabel.text = "Right!"
            feedbackLabel.textColor = UIColor.greenColor()
        } else {
            feedbackLabel.text = "Wrong!"
            feedbackLabel.textColor = UIColor.redColor()
        }
        explanationLabel.text = question.explanation
        self.view.layoutIfNeeded()
        self.explanationHeightConstraint.constant = self.UNBOUNDED_HEIGHT
        UIView.animateWithDuration(0.5, animations: {
            self.explanationView.alpha = 1
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    
    @IBAction func showNextView() {
        if test.hasNextQuestion() {
            performSegueWithIdentifier("showNextQuestion", sender: self)
        } else {
            performSegueWithIdentifier("showTestResults", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTestResults" {
            
        } else if segue.identifier == "showNextQuestion" {
            let dest = segue.destinationViewController as QuestionViewController
            dest.test = test
            dest.question = test.nextQuestion()
        } else {
            assertionFailure("Unrecognized segue identifier from QuestionViewController.")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        answerTextView.delegate = self
        addDismissKeyboardRecognizer()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    // Mark: Keyboard Handling
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var contentInsets = scrollView.contentInset
        contentInsets.bottom = keyboardFrame.height
        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.contentInset = contentInsets
        
        let bottomOffsetY = scrollView.contentSize.height - (scrollView.bounds.size.height-keyboardFrame.height)
        if(bottomOffsetY > 0) {
            scrollView.setContentOffset(CGPointMake(0, bottomOffsetY), animated: true)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var contentInsets = scrollView.contentInset
        contentInsets.bottom = 0
        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.contentInset = contentInsets
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
        answerTextView.resignFirstResponder()
    }
}
