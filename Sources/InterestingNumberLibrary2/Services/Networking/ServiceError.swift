//
//  ServiceError.swift
//  iOS_task3.2
//
//  Created by Roman Ivanov on 03.01.2023.
//

import Foundation

public enum ServiceError: Error, LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("url_is_invalid", bundle: .module, comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("invalid_response_status", bundle: .module, comment: "")
        case .dataTaskError(let string):
            return string
        case .corruptData:
            return NSLocalizedString("corrupt_data", bundle: .module, comment: "")
        case .decodingError(let string):
            return string
        }
    }
}
