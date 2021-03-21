//
//  AirlinesPathResolver.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import Foundation

final class AirlinesPathResolver {
    enum Path {
        case allAirlines
        case airlineLogo(logoPath: String)
    }

    private enum Constants {
        static let airlinesPath = "/h/mobileapis/directory/airlines"
    }

    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func resolve(path: Path) -> String {
        switch path {
        case .allAirlines:
            return baseURL + Constants.airlinesPath
        case .airlineLogo(let logoPath):
            return baseURL + logoPath
        }
    }
}
