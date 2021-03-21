//
//  AppCoordinator.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

final class AppCoordinator {
    private let airlinesRouter: AirlinesRouter

    init(rootNavigation: UINavigationController) {
        self.airlinesRouter = AirlinesRouter(navigation: rootNavigation)
    }

    func start() {
        airlinesRouter.route(to: .list, animated: false)
    }
}
