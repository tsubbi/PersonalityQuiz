//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Jamie Chen on 2021-05-06.
//

import UIKit

class ResultsViewController: UIViewController {
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        
        let titleLabel: UILabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 50)
        titleLabel.text = "text"
        stackView.addArrangedSubview(titleLabel)
        
        let descriptionLabel: UILabel = UILabel()
        descriptionLabel.text = "description"
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        stackView.addArrangedSubview(descriptionLabel)
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Results"
        // bar button item
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        self.navigationItem.rightBarButtonItem = doneButton
        setupView()
        layoutView()
    }
    
    private func setupView() {
        self.view.addSubview(self.contentStackView)
    }
    
    private func layoutView() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.contentStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        self.contentStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        self.contentStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc private func doneButtonAction() {
        print("done")
    }
}
