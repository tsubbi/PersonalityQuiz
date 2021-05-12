//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Jamie Chen on 2021-05-04.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    // Single Answer
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    // Multiple Answers
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    // Ranged Answer
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?", type: .single, answers: [Answer(text: "Stake", type: .dog), Answer(text: "Fish", type: .cat), Answer(text: "Carrots", type: .rabbit), Answer(text: "Corn", type: .turtle)]),
        Question(text: "Which activities do you enjoy?", type: .multiple, answers: [Answer(text: "Swimming", type: .dog), Answer(text: "Sleeping", type: .cat), Answer(text: "Cuddling", type: .rabbit), Answer(text: "Eating", type: .turtle)]),
        Question(text: "How much do you enjoy car ride?", type: .ranged, answers: [Answer(text: "I dislike them", type: .cat), Answer(text: "I get a little nervous", type: .rabbit), Answer(text: "I barely notice them", type: .turtle), Answer(text: "I love them", type: .dog)])
    ]
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        let stackViews = [self.singleStackView, self.multipleStackView, self.rangedStackView]
        stackViews.forEach({ $0?.isHidden = true })
        
        let currentQuestion = self.questions[self.questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        self.navigationItem.title = "Question #\(self.questionIndex + 1)"
        self.questionLabel.text = currentQuestion.text
        self.questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        self.singleStackView.isHidden = false
        let buttons: [UIButton] = [self.singleButton1, self.singleButton2, self.singleButton3, self.singleButton4]
        for (index, button) in buttons.enumerated() {
            button.setTitle(answers[index].text, for: .normal)
        }
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        self.multipleStackView.isHidden = false
        let labels: [UILabel] = [self.multiLabel1, self.multiLabel2, self.multiLabel3, self.multiLabel4]
        for (index, label) in labels.enumerated() {
            label.text = answers[index].text
        }
        [self.multiSwitch1, self.multiSwitch2, self.multiSwitch3, self.multiSwitch4].forEach({
            $0.isOn = false
        })
    }
    
    func nextQuestion() {
        self.questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    func updateRangedStack(using answers: [Answer]) {
        self.rangedStackView.isHidden = false
        self.rangedSlider.setValue(0.5, animated: false)
        self.rangedLabel1.text = answers.first?.text
        self.rangedLabel2.text = answers.last?.text
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = self.questions[questionIndex].answers
        let targetButtons = [self.singleButton1, self.singleButton2, self.singleButton3, self.singleButton4]
        
        guard let index = targetButtons.firstIndex(of: sender) else { return }
        self.answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = self.questions[self.questionIndex].answers
        let targetSwitches: [UISwitch] = [self.multiSwitch1, self.multiSwitch2, self.multiSwitch3, self.multiSwitch4]
        
        targetSwitches.enumerated()
            .filter({ $0.element.isOn })
            .forEach({ self.answersChosen.append(currentAnswers[$0.offset]) })
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(self.rangedSlider.value * Float(currentAnswers.count - 1)))
        
        self.answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
}
