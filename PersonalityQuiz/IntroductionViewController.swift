//
//  ViewController.swift
//  PersonalityQuiz
//
//  Created by Jamie Chen on 2021-05-04.
//

import UIKit

class IntroductionViewController: UIViewController {
    var emojiLabelCollection: [UILabel] = []
    let titleStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Which Animal Are You?"
        label.font = UIFont(name: "Georgia", size: 30)
        label.contentMode = .center
        sv.addArrangedSubview(label)
        
        let button = UIButton(type: .system)
        button.setTitle("Begin Personality Quiz", for: .normal)
        button.addTarget(self, action: #selector(toNextView), for: .touchUpInside)
        sv.addArrangedSubview(button)
        
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        setupView()
        layoutView()
    }

    private func setupView() {
        self.view.addSubview(self.titleStackView)

        for emoji in AnimalCharacters.allCases.map({ $0.emoji }) {
            let label = UILabel()
            label.text = emoji
            label.font = .systemFont(ofSize: 40)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.layoutIfNeeded()
            self.emojiLabelCollection.append(label)
            self.view.addSubview(label)
        }
    }
    
    private func layoutView() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.titleStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        self.titleStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8).isActive = true
        self.titleStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8).isActive = true
        self.titleStackView.heightAnchor.constraint(equalToConstant: 73).isActive = true
        
        for collection in self.emojiLabelCollection.enumerated() {
            if collection.offset == 1 || collection.offset == 2 {
                collection.element.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            } else {
                collection.element.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
            }

            if collection.offset == 1 || collection.offset == 3 {
                collection.element.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
            } else {
                collection.element.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
            }
        }
    }
    
    @objc private func toNextView() {
        let nextVC = QuestionsViewController()
        let navController  = UINavigationController(rootViewController: nextVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}

