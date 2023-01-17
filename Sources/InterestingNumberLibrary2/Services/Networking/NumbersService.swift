//
//  NumbersService.swift
//  iOS_task3.2
//
//  Created by Roman Ivanov on 03.01.2023.
//

import Foundation

@available(macOS 10.15.0, *)
public actor NumbersService {
    var session: URLSession
    let link = "http://numbersapi.com/"
    var dataTask: URLSessionDataTask?

    public init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    public func getFacts(numbers: String) async throws -> [String: String] {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("mock") {
            let sampleData = [
                "2": "2 is the price in cents per acre the USA bought Alaska from Russia.",
                "1": "1 is the number of moons orbiting Earth.",
                "3": "3 is the number of witches in William Shakespeare\'s Macbeth."
            ]

            return sampleData
        }
        #endif

        guard let url = URL(string: link + numbers) else {
            throw ServiceError.invalidURL
        }

        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    continuation.resume(with: .failure(ServiceError.invalidResponseStatus))
                    return
                }
                guard error == nil else {
                    continuation.resume(with: .failure(ServiceError.dataTaskError(error!.localizedDescription)))
                    return
                }
                guard let jsonData = data else {
                    continuation.resume(with: .failure(ServiceError.corruptData))
                    return
                }
                var dictionary: [String: String]?
                if let dict = try? JSONDecoder().decode([String: String].self, from: jsonData) {
                    dictionary = dict
                } else if let number = String(data: jsonData, encoding: .utf8) {
                    dictionary = [numbers: number]
                }

                guard let dictionary = dictionary else {
                    continuation.resume(with: .failure(ServiceError.corruptData))
                    return
                }

                continuation.resume(with: .success(dictionary))
            }.resume()
        }
    }

    private func convertStringToDictionary(text: String) -> [String: String]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(
                    with: data,
                    options: .mutableContainers
                ) as? [String: String]
                return json
            } catch {
                return nil
            }
        }

        return nil
    }
}
