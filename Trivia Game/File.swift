//
//  File.swift
//  Trivia Game
//
//  Created by Carter West on 10/19/18.
//  Copyright © 2018 Carter West. All rights reserved.
//

import Foundation

class TriviaQuestion {
    var question: String
    var answers: [String]
    var correctAnswerIndex: Int
    
    init(question: String, answers: [String], correctAnswerIndex: Int) {
        self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
    
    var correctAnswer: String {
    return answers[correctAnswerIndex]
    }
    
}
