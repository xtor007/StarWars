//
//  Film.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 26.04.2022.
//

import Foundation

struct Film: Codable {
    var title: String
    var episode_id: Int
    var opening_crawl: String
    var director: String
    var producer: String
    var release_date: String
    var characters: [String]
    var planets: [String]
    var starships: [String]
    var vehicles: [String]
    var species: [String]
}
