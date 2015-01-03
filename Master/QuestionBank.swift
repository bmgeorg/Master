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
        topic.name = TopicName.ControlFlow.rawValue
        topic.order = TopicName.ControlFlow.order()
        
        var questions = [Question]()
        
        var question = Question()
        question.type = QuestionType.Text.rawValue
        question.prompt = "What is a virtual method in Java?"
        question.answer = "42"
        question.explanation = "An explanation of a virtual method."
        question.difficulty = 5
        questions.append(question)
        
        question = Question()
        question.type = QuestionType.Binary.rawValue
        question.prompt = "Does Java allow multiple inheritance?"
        question.answer = "No"
        question.difficulty = 3
        questions.append(question)
        
        topic.questions.addObjects(questions)
        RLMRealm.defaultRealm().addObject(topic)
    }
    
    class func generics() {
        let topic = Topic()
        topic.name = TopicName.Generics.rawValue
        topic.order = TopicName.Generics.order()
        
        var questions = [Question]()
        
        var question = Question()
        question.type = QuestionType.Text.rawValue
        question.prompt = "In the class declaration <code>class Box<T>{ /*...*/ }</code> the T is called the (blank)."
        question.answer = "type parameter OR type name"
        question.explanation = "When defining a class, the type parameter, or type variable, is listed in angle quotes following the class name, in this case Box. The type parameter is distinct from the type argument. The type argument is chosen at instantiation time. The type parameter is the placeholder for the type argument in the declaration code."
        question.difficulty = 2
        questions.append(question)
        
        question = Question()
        question.type = QuestionType.Text.rawValue
        question.prompt = "In the instantiation <code>Box<Integer> myBox = new Box<Integer>()</code> Integer is called the (blank)."
        question.answer = "type argument"
        question.explanation = "The type parameter is distinct from the type argument. The type argument is chosen at instantiation time. The type parameter is the placeholder for the type argument in the declaration code."
        question.difficulty = 2
        questions.append(question)
        
        question = Question()
        question.type = QuestionType.Text.rawValue
        question.prompt = "Declare and instantiate a variable 'myBox' of type 'Box' parameterized by type Integer"
        question.answer = "Box<Integer> myBox = new Box<Integer>() OR Box<Integer> myBox = new Box<>()"
        question.explanation = "Explanation"
        question.difficulty = 3
        questions.append(question)
        
        question = Question()
        question.type = QuestionType.Text.rawValue
        question.prompt = "This is a declaration of a Vector parameterized by type Double \n<code>Vector<Double> vec = new Vector<Double>()</code>\nAs of Java 7, Java provides type inference that removes the necessity for one term above. Rewrite the declaration without this term."
        question.answer = "Vector<Double> vec = new Vector<>()"
        question.explanation = "http://docs.oracle.com/javase/tutorial/java/generics/rawTypes.html"
        question.difficulty = 5
        questions.append(question)
        
        question = Question()
        question.type = QuestionType.Binary.rawValue
        question.prompt = "Will the following code give a warning? \n<code>Box<String> stringBox = new Box<>(); \nBox rawBox = stringBox;</code>"
        question.answer = "No"
        question.explanation = "http://docs.oracle.com/javase/tutorial/java/generics/rawTypes.html"
        question.difficulty = 6
        questions.append(question)
        
        question = Question()
        question.type = QuestionType.Text.rawValue
        question.prompt = "Will the following code give a warning? \n<code>Box rawBox = new Box(); \nBox<Integer> intBox = rawBox;</code>"
        question.answer = "Yes"
        question.explanation = "An explanation"
        question.difficulty = 6
        questions.append(question)
        
        topic.questions.addObjects(questions)
        RLMRealm.defaultRealm().addObject(topic)
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