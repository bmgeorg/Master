//
//  Topic.swift
//  Master
//
//  Created by Brett George on 12/26/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit
import Realm

class Topic: RLMObject {
    dynamic var name = "DEFAULT_TOPIC"
    dynamic var order = 0 //designates ordering in list of topics
    dynamic var questions = RLMArray(objectClassName: Question.className())
    var numSolved: Int {
        var count = 0
        for x in questions {
            let q = x as Question
            if(q.solved) {
                count++
            }
        }
        return count
    }
}

enum TopicName: String {
    case ControlFlow = "Control Flow"
    case Generics = "Generics"
    case Nonsense = "Nonsense"
    
    func order() -> Int {
        switch self {
        case .ControlFlow:
            return 0
        case .Generics:
            return 1
        case .Nonsense:
            return 2
        }
    }
}