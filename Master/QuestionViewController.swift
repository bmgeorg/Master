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
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var scrollView: KeyboardHandlingScrollView!
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var answerTextView: PlaceholderTextView!
    
    var question: Question!
    var test: Test!
    
    //Reuse
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        scrollView.keyboardDelegate = self
        questionView.topicLabel.text = question.topic.topic
        questionView.questionTextView.attributedText = TextAttributor.attributeText(question.prompt)
        questionView.explanationTextView.attributedText = TextAttributor.attributeText(question.explanation)
    }
    //end
    
    @IBAction func checkAnswer() {
        //TODO: Don't let user submit empty answer. Prompt to answer.
        /*if answerTextView.text.isEmpty {
            return
        }*/
        enterButton.enabled = false
        answerTextView.editable = false
        answerTextView.textColor = UIColor.grayColor()
        
        //Reuse
        if test.hasNextQuestion() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Bordered, target: self, action: "showNextQuestion")
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Bordered, target: self, action: "finishTest:")
        }
        //end
        
        if(test.submitAnswer(answerTextView.text)) {
            questionView.feedbackLabel.text = "Right!"
            questionView.feedbackLabel.textColor = UIColor.greenColor()
        } else {
            questionView.feedbackLabel.text = "Wrong!"
            questionView.feedbackLabel.textColor = UIColor.redColor()
        }
        
        //Reuse
        questionView.showExplanation()
        //end
    }
    
    @IBAction func finishTest(sender: AnyObject) {
        performSegueWithIdentifier("showTestResults", sender: self)
    }
    
    func showNextQuestion() {
        performSegueWithIdentifier("showNextQuestion", sender: self)
    }
    
    //Reuse
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
    //end
    
    func getActiveField() -> UIView? {
        return answerTextView
    }
    
    func scrollViewShouldReceiveTapAndDismissKeyboard(touch: UITouch) -> Bool {
        return !touch.view.isDescendantOfView(enterButton)
    }
    
    func marginAroundActiveField() -> CGFloat {
        return 8
    }
    
}
