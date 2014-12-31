//
//  QuestionViewController.swift
//  Master
//
//  Created by Brett George on 12/23/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit
import Realm

class QuestionViewController: UIViewController, UITextViewDelegate, KeyboardHandlingScrollViewDelegate {
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var answerTextView: ResizingTextView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var explanationView: UIView!
    @IBOutlet weak var explanationViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var explanationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: KeyboardHandlingScrollView!
    var activeField: UIView?
    
    var question: Question!
    var test: Test!
    
    let UNBOUNDED_HEIGHT: CGFloat = 100000000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        scrollView.keyboardDelegate = self
        topicLabel.text = question.topic.topic
        questionLabel.text = question.prompt
    }
    
    @IBAction func checkAnswer() {
        enterButton.enabled = false
        answerTextView.editable = false
        answerTextView.textColor = UIColor.grayColor()
        if test.hasNextQuestion() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Bordered, target: self, action: "showNextQuestion")
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Bordered, target: self, action: "finishTest:")
        }
        if(test.submitAnswer(answerTextView.text)) {
            feedbackLabel.text = "Right!"
            feedbackLabel.textColor = UIColor.greenColor()
        } else {
            feedbackLabel.text = "Wrong!"
            feedbackLabel.textColor = UIColor.redColor()
        }
        explanationLabel.text = question.explanation
        
        view.layoutIfNeeded()
        explanationHeightConstraint.constant = self.UNBOUNDED_HEIGHT
        explanationViewBottomMargin.constant = 8
        UIView.animateWithDuration(0.5, animations: {
            self.explanationView.alpha = 1
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    @IBAction func finishTest(sender: AnyObject) {
        performSegueWithIdentifier("showTestResults", sender: self)
    }
    
    func showNextQuestion() {
        performSegueWithIdentifier("showNextQuestion", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTestResults" {
            let dest = segue.destinationViewController as TestReportViewController
            dest.report = test.createTestReport()
        } else if segue.identifier == "showNextQuestion" {
            let dest = segue.destinationViewController as QuestionViewController
            dest.test = test
            dest.question = test.nextQuestion()
        } else {
            assertionFailure("Unrecognized segue identifier from QuestionViewController.")
        }
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        activeField = textView
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        activeField = nil
    }
    
    func getActiveField() -> UIView? {
        return activeField
    }
    
    func shouldDismissKeyboardForTap(touch: UITouch) -> Bool {
        return !touch.view.isDescendantOfView(enterButton)
    }
    
    func marginAroundActiveField() -> CGFloat {
        return 8
    }
    
}
