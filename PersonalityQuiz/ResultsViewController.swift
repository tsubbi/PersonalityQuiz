//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Jamie Chen on 2021-05-04.
//

import UIKit

class ResultsViewController: UIViewController {

    var responses: [Answer]
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        calculatePersonalityResult()
    }
    
    func calculatePersonalityResult() {
        let mostCommonAnswer = responses.reduce(into: [AnimalType: Int](), {
            $0[$1.type] = $0[$1.type] != nil ? $0[$1.type]! + 1 : 1
        }).sorted {
            return $0.value > $1.value
        }.first!.key
        self.resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        self.resultDefinitionLabel.text = mostCommonAnswer.defination
    }
}
