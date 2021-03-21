//
//  URL+Extensions.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 28.01.21.
//

import Foundation

extension URL {
    var sanitiseWeb: URL {
        adjustScheme(to: "http")
    }

    private func adjustScheme(to scheme: String) -> URL {
        if var components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            if components.scheme == nil {
                components.scheme = scheme
            }
            return components.url ?? self
        }
        return self
    }
}
