//
//  BinaryQuestionViewController.swift
//  Master
//
//  Created by Brett George on 1/2/15.
//  Copyright (c) 2015 Brett George. All rights reserved.
//

import UIKit

class BinaryQuestionViewController: QuestionViewController {
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupQuestionView(questionView)
    }
    
    @IBAction func finishEarly(sender: UIBarButtonItem) {
        super.finishTest()
    }
    
    @IBAction func answerNo() {
        checkAnswer("No")
    }
    
    @IBAction func answerYes() {
        checkAnswer("Yes")
    }
    
    func checkAnswer(answer: String) {
        yesButton.enabled = false
        noButton.enabled = false
        super.checkAnswer(answer, questionView: questionView)
    }
}
