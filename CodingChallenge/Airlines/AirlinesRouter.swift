//
//  AirlinesRouter.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

final class AirlinesRouter {
    enum Route {
        case list
        case details(airline: Airline)
    }

    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func route(to route: Route, animated: Bool = true) {
        let viewController: UIViewController

        switch route {
        case .list:
            viewController = AirlinesModuleConfigurator.airlinesList(router: self)
        case .details(let airline):
            viewController = AirlinesModuleConfigurator.airlineDetails(for: airline)
        }
        navigation.pushViewController(viewController, animated: animated)
    }
}
