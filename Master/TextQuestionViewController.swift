//
//  TextQuestionViewController.swift
//  Master
//
//  Created by Brett George on 1/2/15.
//  Copyright (c) 2015 Brett George. All rights reserved.
//

import UIKit

class TextQuestionViewController: QuestionViewController, KeyboardHandlingScrollViewDelegate {
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scrollView: KeyboardHandlingScrollView!
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var answerTextView: PlaceholderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupQuestionView(questionView)
        scrollView.keyboardDelegate = self
    }
    
    @IBAction func finishEarly(sender: UIBarButtonItem) {
        super.finishTest()
    }
    
    @IBAction func checkAnswer() {
        //TODO: Don't let user submit empty answer. Prompt to answer.
        /*if answerTextView.text.isEmpty {
        return
        }*/
        submitButton.enabled = false
        answerTextView.editable = false
        answerTextView.textColor = UIColor.grayColor()
        super.checkAnswer(answerTextView.text, questionView: questionView)
    }
    
    func getActiveField() -> UIView? {
        return answerTextView
    }
    
    func scrollViewShouldReceiveTapAndDismissKeyboard(touch: UITouch) -> Bool {
        return !touch.view.isDescendantOfView(submitButton)
    }
    
    func marginAroundActiveField() -> CGFloat {
        return 8
    }
}
