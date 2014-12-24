//
//  QuestionViewController.swift
//  Master
//
//  Created by Brett George on 12/23/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var questionTitle: UINavigationItem!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var question: Question!
    
    internal func configureView() {
        questionTitle.title = question.title
        questionLabel.text = question.question
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
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
}
