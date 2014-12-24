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
        if basicQuestions.count == 0 {
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
            question.solved = true
            questions.append(question)
            
            realm.addObjects(questions)
        }
    }
    
    class func intermediate(realm: RLMRealm) {
        let intermediateQuestions = Question.objectsInRealm(realm, "difficulty = 'intermediate'")
        if intermediateQuestions.count == 0 {
            var questions = [Question]()
            
            var question = Question()
            question.title = "What is a virtual method in Java?"
            question.question = "What is virtual method in Java?"
            question.answer = "42"
            question.difficulty = "intermediate"
            question.solved = true
            questions.append(question)
            
            question = Question()
            question.title = "Does Java allow multiple inheritance?"
            question.question = "Does Java allow multiple inheritance?"
            question.answer = "No"
            question.difficulty = "intermediate"
            questions.append(question)
            
            realm.addObjects(questions)
        }
    }
    
    class func advanced(realm: RLMRealm) {
        let advancedQuestions = Question.objectsInRealm(realm, "difficulty = 'advanced'")
        if advancedQuestions.count == 0 {
            var questions = [Question]()
            
            var question = Question()
            question.title = "Instance Var Instantiation"
            question.question = "Does Java initialize instance variables to 0?"
            question.answer = "Yes"
            question.difficulty = "advanced"
            questions.append(question)
            
            realm.addObjects(questions)
        }
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