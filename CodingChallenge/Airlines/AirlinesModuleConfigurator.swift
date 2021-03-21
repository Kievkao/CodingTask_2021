//
//  AirlinesModuleConfigurator.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

final class AirlinesModuleConfigurator {
    private static let storyboard = UIStoryboard(name: "Airlines", bundle: nil)

    static func airlinesList(router: AirlinesRouter) -> UIViewController {
        let airlinesProvider = AirlinesService(
            pathResolver: AirlinesPathResolver(baseURL: AppConfiguration.baseURL),
            imageLoader: ImageLoader()
        )

        let presenter = AirlinesListPresenter(airlinesProvider: airlinesProvider)

        let viewController = storyboard.instantiateViewController(identifier: "AirlinesListViewController") as! AirlinesListViewController
        viewController.presenter = presenter
        viewController.router = router
        presenter.view = viewController
        
        return viewController
    }

    static func airlineDetails(for airline: Airline) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "AirlineDetailsViewController") as! AirlineDetailsViewController

        let airlinesProvider = AirlinesService(
            pathResolver: AirlinesPathResolver(baseURL: AppConfiguration.baseURL),
            imageLoader: ImageLoader()
        )
        let presenter = AirlineDetailsPresenter(airline: airline, airlinesProvider: airlinesProvider)
        presenter.view = viewController

        viewController.presenter = presenter

        return viewController
    }
}
