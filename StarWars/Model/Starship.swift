//
//  Starship.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 26.04.2022.
//

import Foundation

struct Starship: Decodable {
    var name: String
    var model: String
    var manufacturer: String
    var cost_in_credits: String
    var length: String
    var max_atmosphering_speed: String
    var crew: String
    var passengers: String
    var cargo_capacity: String
    var consumables: String
    var hyperdrive_rating: String
    var MGLT: String
    var starship_class: String
    var pilots: [String]
    var films: [String]
}
