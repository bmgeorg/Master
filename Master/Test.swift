//
//  Test.swift
//  Master
//
//  Created by Brett George on 12/29/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import Foundation
import Realm

class Test {
    let topics: [Topic]
    let questionList: [Question]
    var solved: [Bool]
    var questionIndex = -1
    
    init(topics: [Topic], numQuestions: Int) {
        self.topics = topics
        
        var allQuestions = [Question]()
        for topic in topics {
            for question in topic.questions {
                allQuestions.append(question as Question)
            }
        }
        assert(numQuestions <= allQuestions.count, "Not enough questions in Test.topics")
        
        questionList = [Question]()
        //Randomly select numQuestions from allQuestions to fill questionList
        for i in 0..<numQuestions {
            let idx = i + Int(arc4random())%(numQuestions-i)
            
            //swap questions at i and idx
            let temp = allQuestions[i]
            allQuestions[i] = allQuestions[idx]
            allQuestions[idx] = temp
            
            questionList.append(allQuestions[i])
        }
        
        //Create solved array
        solved = [Bool](count: numQuestions, repeatedValue: false)
    }
    
    func testFinished() -> Bool {
        return questionIndex == questionList.count - 1
    }
    
    func nextQuestion() -> Question {
        assert(!testFinished(), "nextQuestion() called when test is finished.")
        return questionList[++questionIndex]
    }
    
    func submitAnswer(answer: String) -> Bool {
        assert(questionIndex >= 0, "submitAnswer(...) called before test is started.")
        assert(!testFinished(), "submitAnswer(...) called after test is finished.")
        let currentQuestion = questionList[questionIndex]
        RLMRealm.defaultRealm().beginWriteTransaction()
        if currentQuestion.answer.uppercaseString == answer.uppercaseString {
            currentQuestion.solved = true
            solved[questionIndex] = true
            return true
        } else {
            solved[questionIndex] = false
            return false
        }
    }
    
    func createTestReport() -> TestReport {
        assert(testFinished(), "createTestReport() called before test is finished.")
        return TestReport(questions: questions, solved: solved)
    }
}