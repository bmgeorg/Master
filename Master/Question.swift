//
//  Question.swift
//  Quizzer
//
//  Created by Brett George on 12/21/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import Foundation
import Realm

class Question: RLMObject {
    dynamic var prompt = "DEFAULT_QUESTION"
    dynamic var answer = "DEFAULT_ANSWER"
    dynamic var explanation = "DEFAULT_EXPLANATION"
    dynamic var supplementary = "" //Any supplementary information the question requires
    dynamic var difficulty: Int = 0 //0-10 inclusive
    dynamic var solved = false
    dynamic var type = ""
    
    var topic: Topic {
        let linked = linkingObjectsOfClass(Topic.className(), forProperty: "questions")
        assert(linked.count > 0, "Bad data. Question has no backlinked topic.")
        assert(linked.count == 1, "Bad data. Question has more than one backlinked topic.")
        return linked[0] as Topic
    }
}

enum QuestionType: String {
    case Text = "Text"
    case Binary = "Binary"
}