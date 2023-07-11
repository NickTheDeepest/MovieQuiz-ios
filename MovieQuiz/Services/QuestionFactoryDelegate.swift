//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Никита on 20.05.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didRecieveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
