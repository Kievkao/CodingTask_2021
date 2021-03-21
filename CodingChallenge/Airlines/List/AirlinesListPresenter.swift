//
//  AirlinesListPresenter.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

protocol AirlinesListPresentable {
    func getAirlines()
    func getLogo(for airline: Airline, completion: @escaping ((UIImage?) -> Void)) -> UUID?
    func cancelLogoLoading(for token: UUID)
}

final class AirlinesListPresenter: AirlinesListPresentable {
    weak var view: AirlinesListView?

    private let airlinesProvider: AirlinesProvidable

    init(airlinesProvider: AirlinesProvidable) {
        self.airlinesProvider = airlinesProvider
    }

    func getAirlines() {
        view?.startProgress()

        airlinesProvider.fetchAirlines { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.stopProgress()
            }

            switch result {
            case .failure(let error):
                self?.processAirlinesLoadingError(error)

            case .success(let airlines):
                self?.processLoadedAirlines(airlines)
            }
        }
    }

    func getLogo(for airline: Airline, completion: @escaping ((UIImage?) -> Void)) -> UUID? {
        return airlinesProvider.fetchAirlineLogo(for: airline) { result in
            let logo = try? result.get()
            completion(logo ?? UIImage.placeholder80())
        }
    }

    func cancelLogoLoading(for token: UUID) {
        airlinesProvider.cancelAirlineLogoLoading(for: token)
    }

    func processLoadedAirlines(_ airlines: [Airline]) {
        DispatchQueue.main.async {
            self.view?.showAirlines(airlines)
        }
    }

    func processAirlinesLoadingError(_ error: NetworkError) {
        let errorText: String

        switch error {
        case .url:
            errorText = "Incorrect requested URL"
        case .network:
            errorText = "Network error"
        case .noData:
            errorText = "No airlines available"
        case .dataFormat:
            errorText = "Wrong data format"
        }
        DispatchQueue.main.async {
            self.view?.showError(errorText)
        }
    }
}

