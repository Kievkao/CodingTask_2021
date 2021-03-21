//
//  NetworkError.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import Foundation

enum NetworkError: Error {
    case url
    case network
    case noData
    case dataFormat
}
