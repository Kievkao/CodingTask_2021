//
//  Mocks.swift
//  CodingChallengeTests
//
//  Created by Andrii Kravchenko on 28.01.21.
//

import UIKit
@testable import CodingChallenge

final class AirlinesServiceMock: AirlinesProvidable {

    var fetchAirlinesFired = false
    func fetchAirlines(completion: @escaping ((Result<[Airline], NetworkError>) -> Void)) {
        fetchAirlinesFired = true
    }

    var fetchAirlineLogoFired = false
    func fetchAirlineLogo(for airline: Airline, completion: @escaping ((Result<UIImage, NetworkError>) -> Void)) -> UUID? {
        fetchAirlineLogoFired = true
        return UUID(uuidString: "abc")
    }

    func cancelAirlineLogoLoading(for token: UUID) {

    }
}
