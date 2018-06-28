//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by chirag on 21/06/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit
import GameKit

let question_one = Question(theQuestion: "This was the only US President to serve more than two consecutive terms.", possibleAnswers: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], correctAnswerIndex: 2, correctAnswer: "Franklin D. Roosevelt")
let question_two = Question(theQuestion: "Which of the following countries has the most residents?", possibleAnswers: ["Nigeria", "Russia", "Iran", "Vietnam"], correctAnswerIndex: 1, correctAnswer: "Nigeria")
let question_three = Question(theQuestion: "In what year was the United Nations founded?", possibleAnswers: ["1918", "1919", "1945", "1954"], correctAnswerIndex: 3, correctAnswer: "1945")
let question_four = Question(theQuestion: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", possibleAnswers: ["Paris", "Washington D.C.", "New York City", "Boston"], correctAnswerIndex: 3, correctAnswer: "New York City")
let question_five = Question(theQuestion: "Which nation produces the most oil?", possibleAnswers: ["Iran", "Iraq", "Brazil", "Canada"], correctAnswerIndex: 4, correctAnswer: "Canada")
let question_six = Question(theQuestion: "Which country has most recently won consecutive World Cups in Soccer?", possibleAnswers: ["Italy", "Brazil", "Argetina", "Spain"], correctAnswerIndex: 2, correctAnswer: "Brazil")
let question_seven = Question(theQuestion: "Which of the following rivers is longest?", possibleAnswers: ["Yangtze", "Mississippi", "Congo", "Mekong"], correctAnswerIndex: 2, correctAnswer: "Mississippi")
let question_eight = Question(theQuestion: "Which city is the oldest?", possibleAnswers: ["Mexico City", "Cape Town", "San Juan", "Sydney"], correctAnswerIndex: 1, correctAnswer: "Mexico City")
let question_nine = Question(theQuestion: "Which country was the first to allow women to vote in national elections?", possibleAnswers: ["Poland", "United States", "Sweden", "Senegal"], correctAnswerIndex: 1, correctAnswer: "Poland")
let question_ten = Question(theQuestion: "Which of these countries won the most medals in the 2012 Summer Games?", possibleAnswers: ["France", "Germany", "Japan", "Great Britian"], correctAnswerIndex: 4, correctAnswer: "Great Britian")

class Quiz {
    var questions: [Question] = [question_one, question_two, question_three, question_four, question_five, question_six, question_seven, question_eight, question_nine, question_ten]
    var askedQuestions: [Int] = [] // keeping track of asked questions
    // A function to return the question to be asked
    func selectedQuestion() -> Question {
        let index = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count) //generating random number to select the question in questions array.
        if !(self.askedQuestions.contains(index)) {
            self.askedQuestions.append(index)
            return questions[index]
        } else {
            return self.selectedQuestion()
        }
    }
}
