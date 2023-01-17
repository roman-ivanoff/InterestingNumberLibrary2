//
//  Regexes.swift
//  iOS_task3.2
//
//  Created by Roman Ivanov on 13.01.2023.
//

import Foundation

public enum Regexes: String {
    case userNumber = "[0-9]"
    case numberInRange = "^[.0-9]+$*"
    case multipleNumber = "^[,0-9]+$*"

    case numberInRangeForValidation = "[0-9]+[.]{2}[0-9]+"
    case multipleNumberForValidation = "[0-9]+(,[0-9]+)*$"
}
