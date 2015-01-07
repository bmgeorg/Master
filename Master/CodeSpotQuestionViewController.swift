//
//  CodeSpotQuestionViewController.swift
//  Master
//
//  Created by Brett George on 1/3/15.
//  Copyright (c) 2015 Brett George. All rights reserved.
//

import UIKit

class CodeSpotQuestionViewController: QuestionViewController, ClickableCodeViewDelegate {
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var codeView: ClickableCodeView!
    var answerRange: NSRange!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupQuestionView(questionView)
        let text = TextAttributor.attributeText(question.supplementary, defaultFont: codeView.defaultFont())
        codeView.setText(text)
        codeView.clickDelegate = self
        answerRange = findAnswerRange(codeView.codeTextView.textStorage)
        assert(answerRange != nil, "Bad data. No answer found in CodeSpot text.")
    }
    
    @IBAction func finishEarly(sender: UIBarButtonItem) {
        //super.finishTest()
        super.checkAnswer("noanswer", questionView: questionView)
    }
    
    func textWasClickedInRange(range: NSRange, withAttributes attributes: [NSObject: AnyObject]) {
        //check answer
        if attributes["answer"] != nil {
            checkAnswer("", questionView: questionView)
        } else {
            checkAnswer("Wrong Answer", questionView: questionView)
        }
        
        //highlight correct text
        let newText = NSMutableAttributedString(attributedString: codeView.codeTextView.attributedText)
        newText.addAttribute(NSFontAttributeName, value: codeView.defaultFont(), range: NSMakeRange(0, newText.length))
        
        newText.addAttribute(NSForegroundColorAttributeName, value: codeView.codeTextView.tintColor, range: answerRange)
        newText.addAttribute(NSFontAttributeName, value: UIFont(name: "Menlo-Regular", size:UIFont.preferredFontSizeForTextStyle(UIFontTextStyleBody))!, range: answerRange)
        codeView.setText(newText)
    }
    
    func findAnswerRange(storage: NSTextStorage) -> NSRange! {
        var range = NSMakeRange(0, 0)
        var i = 0
        while i < storage.length {
            let attributes = storage.attributesAtIndex(i, longestEffectiveRange: &range, inRange: NSMakeRange(i, storage.length-i))
            if attributes["answer"] != nil {
                return range
            }
            i = range.location + range.length
        }
        return nil
    }
    
}