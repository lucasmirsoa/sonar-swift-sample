//
//  ViewController.swift
//  sonar-swift-sample
//
//  Created by Lucas on 13/08/18.
//  Copyright © 2018 Lucas. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    private lazy var presenter: CalculatePresenter = {
        return CalculatePresenter(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private methods
// Should be, but for test purposes I leave that public

extension CalculateViewController {

    @IBAction func calculateTapped(_ sender: UIButton) {
        self.presenter.calculateViewTapped(firstValue: self.firstTextField.text, secondValue: self.secondTextField.text)
    }
}

// MARK: - View protocol

extension CalculateViewController: CalculateViewProtocol {

    func show(calculationResult: String) {
        self.resultLabel.text = calculationResult
    }
}
