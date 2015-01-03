//
//  QuestionViewController.swift
//  Master
//
//  Created by Brett George on 12/23/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit
import Realm

class QuestionViewController: UIViewController {
    
    var question: Question!
    var test: Test!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    func setupQuestionView(questionView: QuestionView) {
        questionView.topicLabel.text = question.topic.topic
        questionView.questionTextView.attributedText = TextAttributor.attributeText(question.prompt)
        questionView.explanationTextView.attributedText = TextAttributor.attributeText(question.explanation)
    }
    
    func checkAnswer(answer: String, questionView: QuestionView?) -> Bool {
        if test.hasNextQuestion() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Bordered, target: self, action: "showNextQuestion")
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Bordered, target: self, action: "finishTest")
        }
        
        var isCorrect = test.submitAnswer(answer)
        if questionView != nil {
            if(isCorrect) {
                questionView!.feedbackLabel.text = "Right!"
                questionView!.feedbackLabel.textColor = UIColor.greenColor()
            } else {
                questionView!.feedbackLabel.text = "Wrong!"
                questionView!.feedbackLabel.textColor = UIColor.redColor()
            }
            questionView!.showExplanation({ self.view.layoutIfNeeded() })
        }
        return isCorrect
    }
    
    func finishTest() {
        performSegueWithIdentifier("showTestResults", sender: self)
    }
    
    func showNextQuestion() {
        performSegueWithIdentifier("showBinaryQuestion", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTestResults" {
            let dest = segue.destinationViewController as TestReportViewController
            dest.report = test.createTestReport()
        } else if segue.identifier == "showBinaryQuestion" {
            let dest = segue.destinationViewController as QuestionViewController
            dest.test = test
            dest.question = test.nextQuestion()
        } else {
            assertionFailure("Unrecognized segue identifier from QuestionViewController.")
        }
    }
}
