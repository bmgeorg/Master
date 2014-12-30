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
    
    let NUM_QUESTIONS = 2
    
    init(topics: [Topic]) {
        self.topics = topics
        
        var allQuestions = [Question]()
        for topic in topics {
            for question in topic.questions {
                allQuestions.append(question as Question)
            }
        }
        questionList = [Question]()
        
        //Create solved array
        solved = [Bool](count: NUM_QUESTIONS, repeatedValue: false)
        
        assert(NUM_QUESTIONS <= allQuestions.count, "Not enough questions in Test.topics")
        
        //Randomly select numQuestions from allQuestions to fill questionList
        for i in 0..<NUM_QUESTIONS {
            let idx = i + Int(arc4random())%(NUM_QUESTIONS-i)
            
            //swap questions at i and idx
            let temp = allQuestions[i]
            allQuestions[i] = allQuestions[idx]
            allQuestions[idx] = temp
            
            questionList.append(allQuestions[i])
        }
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
            RLMRealm.defaultRealm().commitWriteTransaction()
            return true
        } else {
            solved[questionIndex] = false
            RLMRealm.defaultRealm().commitWriteTransaction()
            return false
        }
    }
    
    func createTestReport() -> TestReport {
        assert(testFinished(), "createTestReport() called before test is finished.")
        return TestReport(questions: questionList, solved: solved)
    }
}