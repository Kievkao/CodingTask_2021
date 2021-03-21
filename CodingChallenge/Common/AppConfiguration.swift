//
//  AppConfiguration.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 28.01.21.
//

import Foundation

final class AppConfiguration {

    static var baseURL: String {
        Bundle.main.infoDictionary?["baseURL"] as? String ?? "https://www.kayak.com"
    }
}
