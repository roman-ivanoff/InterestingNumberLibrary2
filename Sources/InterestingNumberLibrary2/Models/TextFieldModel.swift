//
//  TextFieldModel.swift
//  iOS_task3.2
//
//  Created by Roman Ivanov on 13.01.2023.
//

import Foundation

public class TextFieldModel {
    public static func contains(string: String, regex: String) -> Bool {
        let regexRule = NSPredicate(format: "SELF MATCHES %@ ", regex)
        return regexRule.evaluate(with: string)
    }

    public static func checkBackspace(string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackspace = strcmp(char, "\\b")
            if isBackspace == -92 {
                return true
            }
        }

        return false
    }

    public static func isValidNumberInRange(_ str: String) -> Bool {
        if contains(string: str, regex: Regexes.numberInRangeForValidation.rawValue) {
            let numbers = str.components(separatedBy: CharacterSet.decimalDigits.inverted).filter { $0 != "" }
            guard let first = Int(numbers[0]),
                  let second = Int(numbers[1]) else {
                return false
            }
            return first < second
        }

        return false
    }

    public static func isValidMultipleNumbers(_ str: String) -> Bool {
        let numbers = str.components(separatedBy: CharacterSet.decimalDigits.inverted).filter { $0 != "" }
        return contains(string: str, regex: Regexes.multipleNumberForValidation.rawValue) && numbers.count > 1
    }
}
