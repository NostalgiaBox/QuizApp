import UIKit
import GameKit

class quizQuestion {
    var question = ""
    var answers: [String] = ["", "", "", ""]
    var ans1 = "sad"
    var ans2 = "asd"
    var ans3 = "sad"
    var ans4 = "das"
    var fourAnswers: Bool
    var rightAns = 0
    var wasAsked = false
    
    init(question: String, ans1: String, ans2: String,
         ans3: String, ans4: String, fourAnswers: Bool, rightAns: Int){
        self.question = question
        answers[0] = ans1
        answers[1] = ans2
        answers[2] = ans3
        answers[3] = ans4
        self.fourAnswers = fourAnswers
        self.rightAns = rightAns
    }
    
    func getQuestion() -> String {
        wasAsked = false
        return question
    }
    
    func getAnswers() -> [String] {
        return answers
    }
    
    func isFourAnswers() -> Bool {
        return fourAnswers
    }
    
    func alreadyAsked() -> Bool {
        return wasAsked
    }
    
    func isRightAnswer(choice: Int) -> Bool {
        if choice == rightAns {
            return true
        }
        return false
    }
    
  /*  func displayQuestion() {
       indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(trivia.count)
        let questionDictionary = trivia[indexOfSelectedQuestion]
        questionField.text = questionDictionary["Question"]
        playAgainButton.hidden = true
    }*/
}

let quizQuestions: [quizQuestion] = [quizQuestion(question: "What animal is donald duck", ans1: "Giraffe", ans2: "Turkey", ans3: "Cow", ans4: "Duck", fourAnswers: true, rightAns: 4),
    quizQuestion(question: "What animal is goofy", ans1: "Giraffe", ans2: "Turkey", ans3: "Cow", ans4: "Dog", fourAnswers: true, rightAns: 4),
    quizQuestion(question: "What animal is Mickey", ans1: "Mouse", ans2: "Turkey", ans3: "Cow", ans4: "", fourAnswers: true, rightAns: 1),
    quizQuestion(question: "What animal is pluto", ans1: "Giraffe", ans2: "Dog", ans3: "Cow", ans4: "Duck", fourAnswers: true, rightAns: 2),
    quizQuestion(question: "What animal is Oswald", ans1: "Giraffe", ans2: "Turkey", ans3: "Rabbit", ans4: "Duck", fourAnswers: true, rightAns: 3)
]

class Quiz {
    var questions: [quizQuestion] = []
    var score = 0
    var questionsAsked = 0
    var questionsPerRound = 4
    var currentQuestion: Int = 1
    var isOver = false
    init(questions: [quizQuestion], questionsPerRound: Int) {
        self.questions = questions
        self.questionsPerRound = questionsPerRound
    }
    
    func reset() {
        for question in questions{
            question.wasAsked = false
        }
        score = 0
        questionsAsked = 0
        isOver = false
    }
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            isOver = true
        } else {
            // Continue game
            nextQuestion()
        }
    }
    
    func nextQuestion(){
        var randomNum = 0
        var isNewQuestion = false
        
        questionsAsked += 1
        
        while (isNewQuestion == false){
        randomNum = GKRandomSource.sharedRandom().nextIntWithUpperBound(questions.count)
            if questions[randomNum].wasAsked == false {
                isNewQuestion = true
                questions[randomNum].wasAsked = true
            }
            
        }
        currentQuestion = randomNum
        
    }
    
    func displayAns(answer: Int) -> String {
        switch answer {
            case 1:
                return questions[currentQuestion].answers[0]
            case 2:
                return questions[currentQuestion].answers[1]
            case 3:
                return questions[currentQuestion].answers[2]
            default:
                return questions[currentQuestion].answers[3]
        }
        
    }
    func checkAnswer(answer: Int) -> String{
        
        if answer == questions[currentQuestion].rightAns {
            score += 1
            return "Correct!"
        }
        var correctAns: String
        switch questions[currentQuestion].rightAns {
            case 1:
                correctAns = questions[currentQuestion].answers[0]
            case 2:
                correctAns = questions[currentQuestion].answers[1]
            case 3:
                correctAns = questions[currentQuestion].answers[2]
            default:
                correctAns = questions[currentQuestion].answers[3]
        }
        return "Incorrect, the correct answer was \(correctAns)"
        
    }
    
    func getScore() -> String {
        return "Score: \(score)"
    }
    
    func displayQuestion() -> String{
        
        return questions[currentQuestion].question
    }
    
    func displayScore() -> String{
        // Hide the answer buttons
       // trueButton.hidden = true
       // falseButton.hidden = true
        
        // Display play again button
       // playAgainButton.hidden = false
        
        return "Way to go!\nYou got \(score) out of \(questionsPerRound) correct!"
        
    }
    
 
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
   

}

var quiz = Quiz(questions: quizQuestions, questionsPerRound: 4)