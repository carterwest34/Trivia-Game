//
//  ViewController.swift
//  Trivia Game
//
//  Created by Carter West on 10/18/18.
//  Copyright © 2018 Carter West. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    
    //MARK: Variables
    var questions = [TriviaQuestion]()
    var currentIndex: Int!
    var questionsPlaceholder = [TriviaQuestion]()
    var score = 0 {
        didSet { //This didSet automatically changes the pointsLabel once a change in score is detetcted.
            pointsLabel.text = "Score: \(score)"
        }
    }
    var currentQuestion: TriviaQuestion! {
        didSet { //This didSet automatically changes the text of the question and all answer choices once a change is detected in the currentQuestion
            if let currentQuestion = currentQuestion {
                questionLabel.text = currentQuestion.question
                answerA.setTitle(currentQuestion.answers[0], for: .normal)
                answerB.setTitle(currentQuestion.answers[1], for: .normal)
                answerC.setTitle(currentQuestion.answers[2], for: .normal)
                answerD.setTitle(currentQuestion.answers[3], for: .normal)
                randomButtonColor()
            }
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    
    
    
    //MARK: IBActions
    @IBAction func answerTapepd(_ sender: UIButton) {
        if currentQuestion.correctAnswerIndex == sender.tag {
            score += 1
            showCorrectAnswerAlert()
            //Need to fill out showCorrectAnswerAlert
        } else {
            showIncorrectAnswerAlert()
        }
    }
    
    //Function that will reset the game, the questions, and the points the user has attained.
    @IBAction func resetButtonPressed(_ sender: Any) {
        //Alert that will popup when the user presses the reset button.
        let resetButtonAlert = UIAlertController(title: "Reset", message: "Are you sure you want to reset?", preferredStyle: .actionSheet)
        let resetButtonAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default)
        {UIAlertAction in
            self.resetGame() //reset game if the user clicks yes
        }
        let dontResetButtonAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default)
        resetButtonAlert.addAction(resetButtonAction)
        resetButtonAlert.addAction(dontResetButtonAction)
        self.present(resetButtonAlert, animated: true, completion: nil)
    }
    
    //IBAction needed to create an unwindSegue from the addQuestionViewController to the quiz screen.
     @IBAction func unwindToQuizScreen(segue: UIStoryboardSegue) {}
    
    //MARK: Functions
    
    //Alert with a bit of code that will run when the user guesses an answer correct.
    func showCorrectAnswerAlert() {
        let correctAlert = UIAlertController(title: "Correct! 😃", message: "\(currentQuestion.correctAnswer) is the correct answer! Good work!", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Thank you!", style: UIAlertAction.Style.default)
        {UIAlertAction in //The action will append the questions to the question placeholder array, and remove the question from  the questions array so that you never get the same question again.
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        correctAlert.addAction(okayAction)
        self.present(correctAlert, animated: true, completion: nil)
    }
    
    //Alert with a bit of code that will run when the user guesses an answer incorrect.
    func showIncorrectAnswerAlert() {
        let incorrectAlert = UIAlertController(title: "Incorrect ☹️", message: "\(currentQuestion.correctAnswer) is the correct answer! Thank stinks!", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Thank you!", style: UIAlertAction.Style.default)
        {UIAlertAction in //This action will do the same as the correctAlert because even if we get the question wrong, we dont want to get the same question again.
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        incorrectAlert.addAction(okayAction)
        self.present(incorrectAlert, animated: true, completion: nil)
    }
    
    
    //In the viewDidLoad, we will load the default questions, select random button colors for each answer choice, reset the game to initialize the trivia game view, and allow the user to click away from the text fields to dismiss the keyboard.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateQuestions()
        randomButtonColor()
        resetGame()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    //MARK: Functions
    
    //Default list of questions that will load when the view loads.
    func populateQuestions() {
        let question1 = TriviaQuestion(question: "What is the tallest mammal?", answers: ["Giraffe", "Elephant", "Redwood Tree", "Blue Whale"], correctAnswerIndex: 0)
        questions.append(question1)
        let question2 = TriviaQuestion(question: "What is a perfect score in bowling?", answers: ["100", "300", "250", "1000"], correctAnswerIndex: 1)
        questions.append(question2)
        let question3 = TriviaQuestion(question: "Which of these data types has a decimal point in the value?", answers: ["String", "Integer", "Boolean", "Double/Float"], correctAnswerIndex: 3)
        questions.append(question3)
    }
    
    func randomButtonColor() { //Function that will choose random colors for each button when the view loads, from a pool of 10 colors.
        let colorArray: [UIColor] = [UIColor(red:0.75, green:0.22, blue:0.17, alpha:1.0), UIColor(red:0.95, green:0.77, blue:0.06, alpha:1.0), UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0), UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0), UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0), UIColor(red:0.99, green:0.45, blue:0.45, alpha:1.0), UIColor(red:0.33, green:0.90, blue:0.76, alpha:1.0), UIColor(red:0.43, green:0.13, blue:0.31, alpha:1.0), UIColor(red:1.00, green:0.92, blue:0.65, alpha:1.0), UIColor(red:0.84, green:0.19, blue:0.19, alpha:1.0)]
        answerA.backgroundColor = colorArray[Int.random(in: 0...9)]
        answerB.backgroundColor = colorArray[Int.random(in: 0...9)]
        answerC.backgroundColor = colorArray[Int.random(in: 0...9)]
        answerD.backgroundColor = colorArray[Int.random(in: 0...9)]
    }
    
    
   
    //Alert that shows when the user completes the game.
    func showGameOverAlert() {
        let gameOverAlert = UIAlertController(title: "Trivia Results", message: "Game over. You scored \(score) out of \(questionsPlaceholder.count)", preferredStyle: .actionSheet)
        let tryAgainAction = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.resetGame()
        }
        gameOverAlert.addAction(tryAgainAction)
        self.present(gameOverAlert, animated: true, completion: nil)
    }
    
    //Need to reset game after adding a new question.
    func resetGame() {
       score = 0
        if !questions.isEmpty {
            questionsPlaceholder.append(contentsOf: questions)
            questions.removeAll()
        }
        questions = questionsPlaceholder
        questionsPlaceholder.removeAll()
        getNewQuestion()
    }
    
    //as long as there are questions left in the question array, there will be a random new question chosen from the question array. If there are no questions left, then the gameoveralert will show and the game will end.
   func getNewQuestion() {
        if questions.count > 0 {
            currentIndex = Int.random(in: 0..<questions.count)
            currentQuestion = questions[currentIndex]
        } else {
            showGameOverAlert()
        }
    }
    
   
    
    
    
}
