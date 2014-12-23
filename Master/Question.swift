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
    dynamic var difficulty = "DEFAULT_DIFFICULTY"
    dynamic var title = "DEFAULT_TITLE"
    dynamic var question = "DEFAULT_QUESTION"
    dynamic var answer = "DEFAULT_ANSWER"
}