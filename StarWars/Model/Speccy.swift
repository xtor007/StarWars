//
//  Speccy.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 26.04.2022.
//

import Foundation

struct Speccy: Decodable {
    var name: String
    var classification: String
    var designation: String
    var average_height: String
    var skin_colors: String
    var hair_colors: String
    var eye_colors: String
    var average_lifespan: String
    var homeworld: String?
    var language: String
    var people: [String]
    var films: [String]
}
