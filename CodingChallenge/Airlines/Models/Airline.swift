//
//  Airline.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import Foundation

struct Airline: Decodable {
    let code: String
    let name: String
    let phone: String
    let logoPath: String
    let site: String
}

extension Airline {
    enum CodingKeys: String, CodingKey {
        case code, phone, site
        case logoPath = "logoURL"
        case name = "usName"
    }
}
