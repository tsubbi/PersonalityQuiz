//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Jamie Chen on 2021-05-06.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // views
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        
        return stackView
    }()
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 50)
        label.text = "text"
        return label
    }()
    let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "description"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    // variables
    var response: [Answer]
    
    init(response: [Answer]) {
        self.response = response
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.contentStackView.addArrangedSubview(self.descriptionLabel)
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
