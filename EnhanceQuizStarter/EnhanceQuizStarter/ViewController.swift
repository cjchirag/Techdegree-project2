//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    override func viewDidLoad() {
         super.viewDidLoad()
         loadQuestion()
    }
    
    let gameManager = GameManager()
    var currentQuestion: Question? = nil
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var choiceFour: UIButton!
    
    @IBOutlet weak var playAgain: UIButton!
    func loadQuestion() {
        let theQuestion = gameManager.quiz.selectedQuestion()
        currentQuestion = theQuestion
        questionLabel.text = theQuestion.theQuestion
        choiceOne.setTitle(theQuestion.possibleAnswers[0], for: .normal)
        choiceTwo.setTitle(theQuestion.possibleAnswers[1], for: .normal)
        choiceThree.setTitle(theQuestion.possibleAnswers[2], for: .normal)
        choiceFour.setTitle(theQuestion.possibleAnswers[3], for: .normal)
        playAgain.isHidden = true
    }
    
    func loadScore() {
        choiceOne.isHidden = true
        choiceTwo.isHidden = true
        choiceThree.isHidden = true
        choiceFour.isHidden = true
        playAgain.isHidden = false
        
        if gameManager.score < gameManager.quizRound {
            questionLabel.text = "You got \(gameManager.score) out of \(gameManager.quizRound) correct!"
        } else {
            questionLabel.text = "You scored \(gameManager.score) out of \(gameManager.quizRound)!"
        }
        
    }
    
    func nextRound() {
        if gameManager.questionsAnswered == gameManager.quizRound {
            loadScore()
        } else {
            loadQuestion()
        }
    }
    
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
 
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        gameManager.questionsAnswered += 1
        let currentQs = currentQuestion
    if ((sender === choiceOne) && (gameManager.checkAnswer(answer: choiceOne.title(for: .normal)!, question: currentQs!))){
            questionLabel.text = "You were right :D"
        } else if (sender === choiceTwo && gameManager.checkAnswer(answer: choiceTwo.title(for: .normal)!, question: currentQs!)) {
            questionLabel.text = "You were right :D"
        } else if (sender === choiceThree && gameManager.checkAnswer(answer: choiceThree.title(for: .normal)!, question: currentQs!)) {
            questionLabel.text = "You were right :D"
        } else if (sender === choiceFour && gameManager.checkAnswer(answer: choiceFour.title(for: .normal)!, question: currentQs!)) {
            questionLabel.text = "You were right :D"
        } else {
            questionLabel.text = "That was wrong!!"
        }
        
        loadNextRound(delay: 2)
    }
    @IBAction func playAgain(_ sender: Any) {
        choiceOne.isHidden = false
        choiceTwo.isHidden = false
        choiceThree.isHidden = false
        choiceFour.isHidden = false
        
        gameManager.questionsAnswered = 0
        gameManager.score = 0
        gameManager.quiz.askedQuestions = []
        nextRound()
    }
    
    
    /*
    // MARK: - Properties
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    
    var gameSound: SystemSoundID = 0
    
    let trivia: [[String : String]] = [
        ["Question": "Only female koalas can whistle", "Answer": "False"],
        ["Question": "Blue whales are technically whales", "Answer": "True"],
        ["Question": "Camels are cannibalistic", "Answer": "False"],
        ["Question": "All ducks are birds", "Answer": "True"]
    ]
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        playGameStartSound()
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
        let questionDictionary = trivia[indexOfSelectedQuestion]
        questionField.text = questionDictionary["Question"]
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer uttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = trivia[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict["Answer"]
        
        if (sender === trueButton &&  correctAnswer == "True") || (sender === falseButton && correctAnswer == "False") {
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRound(delay: 2)
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        trueButton.isHidden = false
        falseButton.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    */

}

