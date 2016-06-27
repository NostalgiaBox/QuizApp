//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    var gameSound: SystemSoundID = 0
    
    
    @IBOutlet weak var scoreField: UILabel!
   
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var AnsFourButton: UIButton!
    @IBOutlet weak var AnsThreeButton: UIButton!
    @IBOutlet weak var AnsOneButton: UIButton!
    @IBOutlet weak var AnsTwoButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
      //  loadGameStartSound()
        // Start game
     //   playGameStartSound()
      quiz.nextQuestion()
        changeQuestion()
      questionField.text = quiz.displayQuestion()
        scoreField.text = quiz.getScore()
        showHideAnswers(false)
        enableDisableAnswers(true)
    
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    @IBAction func checkAnswer(sender: UIButton) {
        if (sender == AnsOneButton) {
            questionField.text = quiz.checkAnswer(1)
        } else if (sender == AnsTwoButton) {
            questionField.text = quiz.checkAnswer(2)
        } else if (sender == AnsThreeButton) {
            questionField.text = quiz.checkAnswer(3)
        } else {
            questionField.text = quiz.checkAnswer(4)
        }
        scoreField.text = quiz.getScore()
     
        enableDisableAnswers(false)
        
    /*        quiz.loadNextRoundWithDelay(seconds: 2)
        let delay = Int64(NSEC_PER_SEC * UInt64(2))
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        dispatch_after(dispatchTime, dispatch_get_main_queue()){
            self.changeQuestion()
            
        }*/
        
    }
    
    @IBAction func nextQuestionPressed(sender: UIButton) {
        
        quiz.nextRound()
        enableDisableAnswers(true)
        changeQuestion()
    }
    
    func enableDisableAnswers(enable: Bool){
        AnsOneButton.enabled = enable
        AnsTwoButton.enabled = enable
        AnsThreeButton.enabled = enable
        AnsFourButton.enabled = enable
        nextButton.enabled = !enable
        nextButton.hidden = enable
    }
    
    func showHideAnswers(hide: Bool) {
        AnsOneButton.hidden = hide
        AnsTwoButton.hidden = hide
        AnsThreeButton.hidden = hide
        AnsFourButton.hidden = hide
        playAgainButton.hidden = !(hide)
    }
    
    func endGame() {
        showHideAnswers(true)
        
        questionField.text = quiz.displayScore()
           }
 /*   func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
   */
    
    @IBAction func playAgain() {
     //   Show the answer buttons
        
        quiz.reset()
        showHideAnswers(false)
        quiz.nextRound()
        changeQuestion()
        scoreField.text = quiz.getScore()
        //nextRound()
    }
   
    func changeQuestion() {
    //    questionField.text = "Test"
        questionField.text = quiz.displayQuestion()
        AnsOneButton.setTitle(quiz.displayAns(1), forState: .Normal)
        AnsTwoButton.setTitle(quiz.displayAns(2), forState: .Normal)
        AnsThreeButton.setTitle(quiz.displayAns(3), forState: .Normal)
        if quiz.displayAns(4) == "" {
            AnsFourButton.hidden = true
        }
        else {
            AnsFourButton.hidden = false
            AnsFourButton.setTitle(quiz.displayAns(4), forState: .Normal)
            
        }
        if quiz.isOver == true {
            endGame()
        }
      //  pressAnsTwo.label = quiz.displayAnsTwo()
      //  pressAnsThree.label = quiz.displayAnsThree()
      //  pressAnsFour.label = quiz.displayAnsFour()
    }
    @IBAction func pressAns(sender: UIButton) {
        checkAnswer(sender)
//        quiz.nextQuestion()
        
    }

 /*
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}*/

}