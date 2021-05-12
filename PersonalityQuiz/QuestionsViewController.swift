//
//  QuestionsViewController.swift
//  PersonalityQuiz
//
//  Created by Jamie Chen on 2021-05-06.
//

import UIKit

class QuestionsViewController: UIViewController {
    // views
    let singleQuestionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        for _ in 0...3 {
            let button = UIButton(type: .system)
            button.setTitle("Option", for: .normal)
            button.frame.size.height = 44
            stackView.addArrangedSubview(button)
        }
        return stackView
    }()
    let multipleAnswersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        for _ in 0...3 {
            let hStackView = UIStackView()
            hStackView.axis = .horizontal
            hStackView.alignment = .fill
            hStackView.distribution = .fill
            
            let label = UILabel()
            label.text = "Option"
            hStackView.addArrangedSubview(label)
            let toggleSwitch = UISwitch()
            toggleSwitch.isOn = false
            hStackView.addArrangedSubview(toggleSwitch)
            stackView.addArrangedSubview(hStackView)
        }
        
        let button = UIButton(type: .system)
        button.setTitle("Submit Answer", for: .normal)
        stackView.addArrangedSubview(button)
        
        return stackView
    }()
    let rangedAnswerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let range = UISlider()
        range.minimumValue = 0
        range.maximumValue = 1
        range.value = 0
        stackView.addArrangedSubview(range)
        
        let subStrackView = UIStackView()
        subStrackView.axis = .horizontal
        subStrackView.alignment = .fill
        subStrackView.distribution = .equalSpacing
        
        ["Start", "End"].forEach {
            let label = UILabel()
            label.text = $0
            subStrackView.addArrangedSubview(label)
        }
        stackView.addArrangedSubview(subStrackView)
        
        let button = UIButton(type: .system)
        button.setTitle("Submit Answer", for: .normal)
        stackView.addArrangedSubview(button)
        
        return stackView
    }()
    let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    // variables
    var singleButtons: [UIButton] = []
    var multipleAnswerLabels: [UILabel] = []
    var multipleSwitches: [UISwitch] = []
    var answersChosen: [Answer] = []
    var questionIndex: Int = 0
    var questions: [Question] = [
      Question(text: "Which food do you like the most?",
               type: .single,
               answers: [
                Answer(text: "Steak", type: .dog),
                Answer(text: "Fish", type: .cat),
                Answer(text: "Carrots", type: .rabbit),
                Answer(text: "Corn", type: .turtle)
               ]),
      Question(text: "Which activities do you enjoy?",
               type: .multiple,
               answers: [
                Answer(text: "Swimming", type: .turtle),
                Answer(text: "Sleeping", type: .cat),
                Answer(text: "Cuddling", type: .rabbit),
                Answer(text: "Eating", type: .dog)
               ]),
      Question(text: "How much do you enjoy car rides?",
               type: .ranged,
               answers: [
                Answer(text: "I dislike them", type: .cat),
                Answer(text: "I get a little nervous", type: .rabbit),
                Answer(text: "I barely notice them", type: .turtle),
                Answer(text: "I love them", type: .dog)
               ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupView()
        layoutView()
        updateUI()
    }
    
    private func setupView() {
        self.view.addSubview(self.singleQuestionStackView)
        self.view.addSubview(self.multipleAnswersStackView)
        self.view.addSubview(self.rangedAnswerStackView)
        self.view.addSubview(self.questionLabel)
        self.view.addSubview(self.progressView)
        
        // extract out the buttons in stackview
        self.singleQuestionStackView.subviews
            .filter({ $0 is UIButton })
            .forEach({
                let btn = ($0 as! UIButton)
                btn.addTarget(self, action: #selector(singleAnswerButtonPressed(_:)), for: .touchUpInside)
                self.singleButtons.append(btn)
            })
        
        // extract out the labels and buttons in stackView
        self.multipleAnswersStackView.subviews
            .filter({ $0 is UIStackView })
            .forEach { stackView in
                guard let sv = stackView as? UIStackView else { return }
                sv.subviews.forEach({
                    switch $0 {
                    case is UILabel:
                        self.multipleAnswerLabels.append(($0 as! UILabel))
                    case is UISlider:
                        self.multipleSwitches.append(($0 as! UISwitch))
                    default:
                        break
                    }
                })
            }
        // add button action
        let multipleAnswerButton = self.multipleAnswersStackView.subviews.filter({ $0 is UIButton }).first as! UIButton
        multipleAnswerButton.addTarget(self, action: #selector(multipleAnswerButtonPressed), for: .touchUpInside)
        let rangeAnswerButton = self.rangedAnswerStackView.subviews.filter({ $0 is UIButton }).first as! UIButton
        rangeAnswerButton.addTarget(self, action: #selector(rangedAnswerButtonPressed), for: .touchUpInside)
    }
    
    private func layoutView() {
        let safeArea = self.view.safeAreaLayoutGuide
        let subViews: [UIView] = [
            self.questionLabel,
            self.progressView,
            self.singleQuestionStackView,
            self.multipleAnswersStackView,
            self.rangedAnswerStackView
        ]

        subViews.forEach {
            $0.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
            switch $0 {
            case is UILabel:
                // this is the label at top
                $0.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
            case is UIProgressView:
                // this is the progress view at bottom
                $0.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
            default:
                // default is the stackviews
                $0.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
            }
        }
    }
    
    private func updateUI() {
        self.singleQuestionStackView.isHidden = true
        self.multipleAnswersStackView.isHidden = true
        self.rangedAnswerStackView.isHidden = true
        
        let currentQuestion = self.questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(self.questionIndex)/Float(self.questions.count)
        
        navigationItem.title = "Question #\(self.questionIndex+1)"
        self.questionLabel.text = currentQuestion.text
        self.progressView.setProgress(totalProgress, animated: true)
  
        switch currentQuestion.type {
        case .single:
            self.updateSingleStack(using: currentAnswers)
        case .multiple:
            self.updateMultipleStack(using: currentAnswers)
        case .ranged:
            self.updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        self.singleQuestionStackView.isHidden = false
        self.singleButtons.enumerated().forEach {
            $0.element.setTitle(answers[$0.offset].text, for: .normal)
        }
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        self.multipleAnswersStackView.isHidden = false
        self.multipleAnswerLabels.enumerated().forEach({ $0.element.text = answers[$0.offset].text })
        self.multipleSwitches.forEach({ $0.isOn = false })
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedAnswerStackView.isHidden = false
        guard
            let horizontalStackView = self.rangedAnswerStackView.subviews.filter({ $0 is UIStackView }).first! as? UIStackView,
            let label1 = horizontalStackView.subviews.first as? UILabel,
            let label2 = horizontalStackView.subviews.last as? UILabel,
            let slider = self.rangedAnswerStackView.subviews.filter({ $0 is UISlider }).first as? UISlider
        else { return }
        slider.setValue(0.5, animated: false)
        label1.text = answers.first?.text
        label2.text = answers.last?.text
    }
    
    @objc func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = self.questions[questionIndex].answers
        
        guard let index = self.singleButtons.firstIndex(of: sender) else { return }
        self.answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    @objc func multipleAnswerButtonPressed() {
        let currentAnswer = self.questions[self.questionIndex].answers
        
        self.multipleSwitches.enumerated()
            .filter({ $0.element.isOn })
            .forEach({ self.answersChosen.append(currentAnswer[$0.offset]) })
        
        nextQuestion()
    }
    
    @objc func rangedAnswerButtonPressed() {
        let currentAnswer = self.questions[self.questionIndex].answers
        guard let slider: UISlider = self.rangedAnswerStackView.subviews.filter({ $0 is UISlider }).first as? UISlider else { return }
        let index = Int(round(slider.value) * Float(currentAnswer.count - 1))
        self.answersChosen.append(currentAnswer[index])
        
        nextQuestion()
    }
    
    func nextQuestion() {
        self.questionIndex += 1
        if self.questionIndex < self.questions.count {
            updateUI()
        } else {
            let resultVC = ResultsViewController(response: self.answersChosen)
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
    }
}
