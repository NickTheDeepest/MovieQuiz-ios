//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Никита on 20.05.2023.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)
    let id: String
}
