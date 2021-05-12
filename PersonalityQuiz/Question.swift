//
//  Question.swift
//  PersonalityQuiz
//
//  Created by Jamie Chen on 2021-05-12.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    var text: String
    var type: AnimalCharacters
}
