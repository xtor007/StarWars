//
//  Vehicle.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 26.04.2022.
//

import Foundation

struct Vehicle: Decodable {
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
    var vehicle_class: String
    var pilots: [String]
    var films: [String]
}
