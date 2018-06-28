//
//  Question.swift
//  EnhanceQuizStarter
//
//  Created by chirag on 21/06/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit
import GameKit
// struct to model questions
struct Question {
    var theQuestion: String
    var possibleAnswers: [String]
    var correctAnswerIndex: Int
    var correctAnswer: String
}
