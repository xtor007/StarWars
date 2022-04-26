//
//  APIError.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 25.04.2022.
//

import Foundation

struct APIError: Decodable {
    var debug: Debug
}

struct Debug: Decodable {
    var status: Int
    var statusText: String
}
