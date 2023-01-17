//
//  NumberModel.swift
//  iOS_task3.2
//
//  Created by Roman Ivanov on 04.01.2023.
//

import Foundation

@available(macOS 10.15.0, *)
public class NumberModel {
    public var facts: [Fact] = []
    let numbersService = NumbersService()
    public let number: String

    public init(number: String) {
        self.number = number
    }

    public func getFacts(
        numbers: String,
        onSuccess: @escaping([Fact]) -> Void,
        onError: @escaping(ServiceError) -> Void
    ) {
        Task {
            do {
                facts = try await self.convertDictionaryToFacts(numbersService.getFacts(numbers: numbers))
                onSuccess(facts)
            } catch {
                onError(error as! ServiceError)
            }
        }
    }

    private func convertDictionaryToFacts(_ dictionary: [String: String]) -> [Fact] {
        var facts: [Fact] = []

        for (key, val) in dictionary {
            facts.append(Fact(number: key, fact: val))
        }

        return facts
    }
}
