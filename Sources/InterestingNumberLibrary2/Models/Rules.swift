//
//  Rules.swift
//  iOS_task3.2
//
//  Created by Roman Ivanov on 13.01.2023.
//

import Foundation

public struct OnlyNumbersRule: InputRuleProtocol {
    let regex: String

    public init(regex: String) {
        self.regex = regex
    }

    public func rule(string: String) -> Bool {
        if TextFieldModel.checkBackspace(string: string) {
            return true
        }

        return TextFieldModel.contains(string: string, regex: regex)
    }
}
