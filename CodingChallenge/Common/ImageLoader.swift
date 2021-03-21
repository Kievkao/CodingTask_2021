//
//  ImageLoader.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

protocol ImageLoadable {
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, NetworkError>) -> Void) -> UUID?
    func cancelLoad(_ uuid: UUID)
}

final class ImageLoader: ImageLoadable {
    private static var cache = AtomicDict<URL, UIImage>()
    private var runningRequests = AtomicDict<UUID, URLSessionDataTask>()

    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, NetworkError>) -> Void) -> UUID? {
        if let image = Self.cache[url] {
            completion(.success(image))
            return nil
        }
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.runningRequests[uuid] = nil
            }

            if let data = data, let image = UIImage(data: data) {
                Self.cache[url] = image
                return completion(.success(image))
            }

            if let error = error, (error as NSError).code != NSURLErrorCancelled {
                completion(.failure(.network))
            }
        }
        task.resume()
        runningRequests[uuid] = task
        return uuid
    }

    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests[uuid] = nil
    }
}

