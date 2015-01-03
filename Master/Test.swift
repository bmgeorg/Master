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
    var currentQuestion: Question?
    
    let NUM_QUESTIONS = 4
    
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
            let idx = i + Int(arc4random())%(allQuestions.count-i)
            //swap questions at i and idx
            let temp = allQuestions[i]
            allQuestions[i] = allQuestions[idx]
            allQuestions[idx] = temp
            questionList.append(allQuestions[i])
        }
    }
    
    func hasNextQuestion() -> Bool {
        return questionIndex+1 < NUM_QUESTIONS
    }
    
    func nextQuestion() -> Question {
        assert(hasNextQuestion(), "nextQuestion() called and there are no more questions.")
        currentQuestion = questionList[++questionIndex]
        return currentQuestion!
    }
    
    func submitAnswer(answer: String) -> Bool {
        assert(questionIndex >= 0, "submitAnswer(...) called before test is started.")
        assert(questionIndex < NUM_QUESTIONS, "submitAnswer(...) called after test is finished.")
        RLMRealm.defaultRealm().beginWriteTransaction()
        var isCorrect = false
        if currentQuestion!.answer.uppercaseString == answer.uppercaseString {
            currentQuestion!.solved = true
            solved[questionIndex] = true
            isCorrect = true
        } else {
            solved[questionIndex] = false
            isCorrect = false
        }
        RLMRealm.defaultRealm().commitWriteTransaction()
        return isCorrect
    }
    
    
    func createTestReport() -> TestReport {
        return TestReport(questions: questionList, solved: solved)
    }
}