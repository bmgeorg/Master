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
    
    class func basic(realm: RLMRealm) {
        let basicQuestions = Question.objectsInRealm(realm, "difficulty = 'basic'")
        if basicQuestions.count >= 0 {
            var questions = [Question]()
            
            var question = Question()
            question.title = "What is a virtual method in Java?"
            question.question = "What is virtual method in Java?"
            question.answer = "42"
            question.difficulty = "basic"
            questions.append(question)
            
            question = Question()
            question.title = "Does Java allow multiple inheritance?"
            question.question = "Does Java allow multiple inheritance?"
            question.answer = "No"
            question.difficulty = "basic"
            questions.append(question)
            
            realm.addObjects(questions)
        }
    }
    
    class func intermediate(realm: RLMRealm) {
        
    }
    
    class func advanced(realm: RLMRealm) {
        
    }
    
    class func populateQuestions() {
        let realm = RLMRealm.defaultRealm()
        
        realm.beginWriteTransaction()
        
        realm.deleteAllObjects()
        
        basic(realm)
        intermediate(realm)
        advanced(realm)
        
        realm.commitWriteTransaction()
    }
}