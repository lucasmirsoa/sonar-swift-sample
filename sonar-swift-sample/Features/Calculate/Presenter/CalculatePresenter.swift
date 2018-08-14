//
//  CalculatePresenter.swift
//  sonar-swift-sample
//
//  Created by Lucas on 13/08/18.
//  Copyright © 2018 Lucas. All rights reserved.
//

final class CalculatePresenter {

    private unowned var view: CalculateViewProtocol

    init(view: CalculateViewProtocol) {
        self.view = view
    }
}

// MARK: - Private methods
// Should be, but for test purposes I leave that public

extension CalculatePresenter {

    func tryGenerateOperation(firstValue: String?, secondValue: String?) -> Operation? {
        guard let first = firstValue, let firstValue = Int(first) else { return nil }
        guard let second = secondValue, let secondValue = Int(second) else { return nil }

        return Operation(value1: firstValue, value2: secondValue)
    }

    func calculate(operation: Operation?, testing: Bool? = false) {
        guard let operation = operation else { return }
        guard testing == false else { return }
        self.view.show(calculationResult: String(operation.value1 * operation.value2))
    }
}

// MARK: - Public methods

extension CalculatePresenter {

    func calculateViewTapped(firstValue: String?, secondValue: String?) {
        self.calculate(operation: self.tryGenerateOperation(firstValue: firstValue, secondValue: secondValue))
    }
}
