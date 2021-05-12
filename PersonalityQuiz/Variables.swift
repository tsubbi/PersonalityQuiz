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
    
    var definition: String {
            switch self {
            case .dog:
                return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
            case .cat:
                return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
            case .rabbit:
                return "You love everything that’s soft. You are healthy and full of energy."
            case .turtle:
                return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
            }
        }
}
