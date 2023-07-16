//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Никита on 20.05.2023.
//

import Foundation
import UIKit

protocol AlertPresenterProtocol {
    func show(_ model: AlertModel)
}


class AlertPresenter: AlertPresenterProtocol {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func show(_ model: AlertModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = model.id
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
            
        }
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
}

