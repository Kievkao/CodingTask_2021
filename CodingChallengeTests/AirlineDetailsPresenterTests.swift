//
//  AirlineDetailsPresenterTests.swift
//  CodingChallengeTests
//
//  Created by Andrii Kravchenko on 28.01.21.
//

import XCTest
@testable import CodingChallenge

class AirlineDetailsPresenterTests: XCTestCase {
    var presenter: AirlineDetailsPresenter!
    var airlinesProviderMock: AirlinesServiceMock!

    override func setUpWithError() throws {
        airlinesProviderMock = AirlinesServiceMock()
        presenter = AirlineDetailsPresenter(
            airline: Airline(code: "AB", name: "Name", phone: "123455", logoPath: "", site: ""),
            airlinesProvider: airlinesProviderMock
        )
    }

    func testGetAirlineDetails() {
        XCTAssertFalse(airlinesProviderMock.fetchAirlineLogoFired)
        presenter.getAirlineDetails()
        XCTAssertTrue(airlinesProviderMock.fetchAirlineLogoFired)
    }
}
