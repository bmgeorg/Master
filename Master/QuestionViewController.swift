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
        questionView.topicLabel.text = question.topic.name
        let viewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        questionView.questionTextView.attributedText = TextAttributor.attributeText(question.prompt, defaultFont: viewFont)
        questionView.explanationTextView.attributedText = TextAttributor.attributeText(question.explanation, defaultFont: viewFont)
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
        let nextQuestion = test.nextQuestion()
        let type = QuestionType(rawValue: nextQuestion.type)
        assert(type != nil, "Bad data. QuestionType enum could not be created from question.type")
        switch type! {
        case QuestionType.Text:
            performSegueWithIdentifier("showTextQuestion", sender: self)
        case QuestionType.Binary:
            performSegueWithIdentifier("showBinaryQuestion", sender: self)
        case QuestionType.CodeSpot:
            performSegueWithIdentifier("showCodeSpotQuestion", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTestResults" {
            let dest = segue.destinationViewController as TestReportViewController
            dest.report = test.createTestReport()
        } else {
            let dest = segue.destinationViewController as QuestionViewController
            dest.test = test
            dest.question = test.currentQuestion!
        }
    }
}
