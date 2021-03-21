//
//  AirlinesService.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

protocol AirlinesProvidable {
    func fetchAirlines(completion: @escaping ((Result<[Airline], NetworkError>) -> Void))
    @discardableResult func fetchAirlineLogo(for airline: Airline, completion: @escaping ((Result<UIImage, NetworkError>) -> Void)) -> UUID?
    func cancelAirlineLogoLoading(for token: UUID)
}

final class AirlinesService: AirlinesProvidable {
    private let pathResolver: AirlinesPathResolver
    private let imageLoader: ImageLoadable

    init(pathResolver: AirlinesPathResolver, imageLoader: ImageLoadable) {
        self.pathResolver = pathResolver
        self.imageLoader = imageLoader
    }

    func fetchAirlines(completion: @escaping ((Result<[Airline], NetworkError>) -> Void)) {
        guard let url = URL(string: pathResolver.resolve(path: .allAirlines)) else {
            return completion(.failure(.url))
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                return completion(.failure(.network))
            }

            guard let data = data else {
                return completion(.failure(.noData))
            }

            guard let airlines = try? JSONDecoder().decode([Airline].self, from: data) else {
                return completion(.failure(.dataFormat))
            }
            
            completion(.success(airlines))
        }.resume()
    }

    @discardableResult func fetchAirlineLogo(for airline: Airline, completion: @escaping ((Result<UIImage, NetworkError>) -> Void)) -> UUID? {
        guard let logoURL = URL(string: pathResolver.resolve(path: .airlineLogo(logoPath: airline.logoPath))) else {
            completion(.failure(.url))
            return nil
        }

        return imageLoader.loadImage(logoURL, completion)
    }

    func cancelAirlineLogoLoading(for token: UUID) {
        imageLoader.cancelLoad(token)
    }
}

