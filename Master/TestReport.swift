//
//  TestReport.swift
//  Master
//
//  Created by Brett George on 12/29/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import Foundation

class TestReport {
    let questions: [Question]
    let solved: [Bool]
    init(questions: [Question], solved: [Bool]) {
        assert(questions.count == solved.count, "Unequal counts in questions and solved in TestReport init")
        self.questions = questions
        self.solved = solved
    }
}