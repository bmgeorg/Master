//
//  CodeSpotQuestionViewController.swift
//  Master
//
//  Created by Brett George on 1/3/15.
//  Copyright (c) 2015 Brett George. All rights reserved.
//

import UIKit

class CodeSpotQuestionViewController: QuestionViewController {
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var codeView: CodeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupQuestionView(questionView)
    }
    
    override func viewWillAppear(animated: Bool) {
        codeView.setText(question.supplementary)
    }
    
    @IBAction func finishEarly(sender: UIBarButtonItem) {
        //super.finishTest()
        super.checkAnswer("noanswer", questionView: questionView)
    }
    
    func checkAnswer(answer: String) {
        
    }
    
}