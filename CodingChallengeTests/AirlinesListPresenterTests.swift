//
//  AirlinesListPresenterTests.swift
//  CodingChallengeTests
//
//  Created by Andrii Kravchenko on 28.01.21.
//

import XCTest
@testable import CodingChallenge

class AirlinesListPresenterTests: XCTestCase {
    var presenter: AirlinesListPresenter!
    var airlinesProviderMock: AirlinesServiceMock!

    override func setUpWithError() throws {
        airlinesProviderMock = AirlinesServiceMock()
        presenter = AirlinesListPresenter(airlinesProvider: airlinesProviderMock)
    }

    func testGetAirlines() {
        XCTAssertFalse(airlinesProviderMock.fetchAirlinesFired)
        presenter.getAirlines()
        XCTAssertTrue(airlinesProviderMock.fetchAirlinesFired)
    }
}
