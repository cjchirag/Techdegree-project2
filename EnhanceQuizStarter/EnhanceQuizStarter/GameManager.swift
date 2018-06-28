//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by chirag on 21/06/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit

// Instance for the Quiz class
let selectedQuiz = Quiz()

class GameManager {
    var quiz: Quiz = selectedQuiz
    var score: Int = 0
    var questionsAnswered: Int = 0
    
    var quizRound: Int {
        return selectedQuiz.questions.count
    }
    
    func checkAnswer(answer: String, question: Question) -> Bool {
        if answer == question.correctAnswer {
            self.score += 1
            return true
        } else {
            return false
        }
    }
}
