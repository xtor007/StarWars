//
//  Planet.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 26.04.2022.
//

import Foundation

struct Planet: Decodable {
    var name: String
    var rotation_period: String
    var orbital_period: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surface_water: String
    var residents: [String]
    var films: [String]
}
