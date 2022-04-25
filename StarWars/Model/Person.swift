//
//  Person.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 25.04.2022.
//

import Foundation

struct Person: Decodable {
    var name: String
    var height: Int
    var mass: Int
    var hair_color: String
    var scin_color: String
    var eye_color: String
    var birth_year: String
    var gender: String
    var homeworld: String
    var films: [String]
    var species: [String]
    var vehicles: [String]
    var starships: [String]
}
