//
//  AddQuestionViewController.swift
//  Trivia Game
//
//  Created by Carter West on 10/19/18.
//  Copyright © 2018 Carter West. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    
    //MARK: IBOutlets and Variables
    @IBOutlet weak var newQuestionTextField: UITextField!
    @IBOutlet weak var answerATextField: UITextField!
    @IBOutlet weak var answerBTextField: UITextField!
    @IBOutlet weak var answerCTextField: UITextField!
    @IBOutlet weak var answerDTextField: UITextField!
    @IBOutlet weak var correctAnswerSegmentedController: UISegmentedControl!
    var newTrivia: TriviaQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //This code will make it to where the keyboard will be dimissed when we click away from the text field.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    //MARK: IBActions
    @IBAction func addButtonTapped(_ sender: Any) {
        guard //Validation that makles sure that there's something entered into each text field.
        let question = newQuestionTextField.text, !question.isEmpty,
            let answerA = answerATextField.text, !answerA.isEmpty,
            let answerB = answerBTextField.text, !answerB.isEmpty,
            let answerC = answerCTextField.text, !answerC.isEmpty,
            let answerD = answerDTextField.text, !answerD.isEmpty
            
            else { //If there's a text field thats empty, this code will run.
            let errorAlert = UIAlertController(title: "Error", message: "Please fill all fields or press cancel to return to quiz.", preferredStyle: UIAlertController.Style.alert)
                let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {UIAlertAction in} //No code will go along with this action, so nothing will go in the brackets.
                errorAlert.addAction(dismissAction)
            self.present(errorAlert, animated: true, completion: nil)
                return //No more code will run if there is an empty text field.
        }
        //Code that will make a new question and append it to the array.
        newTrivia = TriviaQuestion(question: question, answers: [answerA, answerB, answerC, answerD], correctAnswerIndex: correctAnswerSegmentedController.selectedSegmentIndex)
        performSegue(withIdentifier: "UnwindSegueToQuizScreen", sender: self) //Perform segue after done adding question so that it takes us back to the quiz screen.
    }
    
    //IBAction that correlates with the cancel button on the add question screen.
    @IBAction func returnToQuizScreen(_ sender: Any) {
        performSegue(withIdentifier: "UnwindSegueToQuizScreen", sender: self)
    }
    
    
    //MARK: Functions
    //prepares the sugue so that the new question will be added to the question array and checks newTriviaQuestion to make sure its of type newTrivia.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
        let destinationVC = segue.destination as? QuizViewController,
        let newTriviaQuestion = newTrivia
        else {return}
        destinationVC.questions.append(newTriviaQuestion)
        destinationVC.resetGame()
    }
    
}

