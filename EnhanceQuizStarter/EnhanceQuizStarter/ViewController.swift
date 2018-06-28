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
    
    var gameSound: SystemSoundID = 0
    
    override func viewDidLoad() {
         super.viewDidLoad()
         loadQuestion()
         loadGameStartSound()
         playGameStartSound()
    }
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
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
    // Calls the nextRound according to the state of game. If all questions are answered.. score is displayed. else next question is displayed.
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
 
    // A function check answers.. input is the button pressed by the user.
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
    // Function is called when a round of game is over.
    @IBAction func playAgain(_ sender: Any) {
        choiceOne.isHidden = false
        choiceTwo.isHidden = false
        choiceThree.isHidden = false
        choiceFour.isHidden = false
        //Reseting game attributes.
        gameManager.questionsAnswered = 0
        gameManager.score = 0
        gameManager.quiz.askedQuestions = []
        nextRound()
    }

}

