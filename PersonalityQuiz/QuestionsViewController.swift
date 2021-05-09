//
//  QuestionsViewController.swift
//  PersonalityQuiz
//
//  Created by Jamie Chen on 2021-05-06.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    let singleQuestionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        for i in 0...3 {
            let button = UIButton(type: .system)
            button.setTitle("Option \(i+1)", for: .normal)
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
        
        for i in 0...3 {
            let hStackView = UIStackView()
            hStackView.axis = .horizontal
            hStackView.alignment = .fill
            hStackView.distribution = .fill
            
            let label = UILabel()
            label.text = "Option \(i+1)"
            hStackView.addArrangedSubview(label)
            let toggleSwitch = UISwitch()
            toggleSwitch.isOn = true
            hStackView.addArrangedSubview(toggleSwitch)
            stackView.addArrangedSubview(hStackView)
        }
        
        let button = UIButton(type: .system)
        button.setTitle("Submit Answer", for: .normal)
        stackView.addArrangedSubview(button)
        
        return stackView
    }()
    
    let rangeAnswerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let range = UISlider()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupView()
        layoutView()
    }
    
    private func setupView() {
        self.view.addSubview(self.singleQuestionStackView)
        self.view.addSubview(self.multipleAnswersStackView)
        self.view.addSubview(self.rangeAnswerStackView)
    }
    
    private func layoutView() {
        let safeArea = self.view.safeAreaLayoutGuide
        let stackViews: [UIStackView] = [
            self.singleQuestionStackView,
            self.multipleAnswersStackView,
            self.rangeAnswerStackView
        ]

        stackViews.forEach({
            $0.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        })
    }
}
