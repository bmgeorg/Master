//
//  QuestionBank.swift
//  Quizzer
//
//  Created by Brett George on 12/22/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import Foundation
import Realm

class QuestionBank {
    
    class func controlFlow() {
        let topic = Topic()
        topic.topic = "Control Flow"
        topic.order = orderForTopic("Control Flow")
        
        var questions = [Question]()
        
        var question = Question()
        question.prompt = "What is a virtual method in Java?"
        question.answer = "42"
        question.explanation = "An explanation of a virtual method."
        question.difficulty = 5
        question.solved = true
        questions.append(question)
        
        question = Question()
        question.prompt = "Does Java allow multiple inheritance?"
        question.answer = "No"
        question.difficulty = 3
        questions.append(question)
        
        topic.questions.addObjects(questions)
        RLMRealm.defaultRealm().addObject(topic)
    }
    
    class func generics() {
        let topic = Topic()
        topic.topic = "Generics"
        topic.order = orderForTopic("Generics")
        
        var questions = [Question]()
        
        var question = Question()
        question.prompt = "What is a virtual method in Java?"
        question.answer = "42"
        question.explanation = "An explanation of a virtual method."
        question.difficulty = 5
        questions.append(question)
        
        question = Question()
        question.prompt = "Does Java allow multiple inheritance?"
        question.answer = "No"
        question.difficulty = 3
        questions.append(question)
        
        topic.questions.addObjects(questions)
        RLMRealm.defaultRealm().addObject(topic)
    }
    
    class func orderForTopic(topic: String) -> Int {
        if(topic == "Control Flow") {
            return 0;
        }
        if(topic == "Generics") {
            return 1;
        }
        assertionFailure("Unrecognized topic in QuestionBank")
    }
    
    class func populateQuestions() {
        let realm = RLMRealm.defaultRealm()
        
        realm.beginWriteTransaction()
        realm.deleteAllObjects()
        
        controlFlow()
        generics()
        
        realm.commitWriteTransaction()
    }
}