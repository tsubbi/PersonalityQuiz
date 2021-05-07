//
//  Variables.swift
//  PersonalityQuiz
//
//  Created by Jamie Chen on 2021-05-06.
//

import Foundation

enum AnimalCharacters: String, CaseIterable {
    case dog
    case cat
    case rabbit
    case turtle
    
    var emoji: String {
        switch self {
        case .dog:
            return "🐶"
        case .cat:
            return "🐱"
        case .rabbit:
            return "🐰"
        case .turtle:
            return "🐢"
        }
    }
}
