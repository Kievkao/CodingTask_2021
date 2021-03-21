//
//  AirlineDetailsPresenter.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

protocol AirlineDetailsPresentable {
    func getAirlineDetails()
}

final class AirlineDetailsPresenter: AirlineDetailsPresentable {
    weak var view: AirlineDetailsView?
    
    private let airline: Airline
    private let airlinesProvider: AirlinesProvidable

    init(airline: Airline, airlinesProvider: AirlinesProvidable) {
        self.airline = airline
        self.airlinesProvider = airlinesProvider
    }

    func getAirlineDetails() {
        airlinesProvider.fetchAirlineLogo(for: airline) { [weak self] result in
            guard let self = self else { return }
            let logo = try? result.get()

            let website = self.airline.site.isEmpty ? NSAttributedString(string: "No website provided") : self.airline.site.underscored()
            let phone = self.airline.phone.isEmpty ? NSAttributedString(string: "No phone provided") : self.airline.phone.underscored()

            self.view?.show(name: self.airline.name, logo: logo, website: website, phone: phone)
        }
    }
}
