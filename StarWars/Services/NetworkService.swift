//
//  NetworkService.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 25.04.2022.
//

import Foundation

class NetworkService {
    
    static let server = NetworkService()
    
    private func getCountOfPeople(onSuccess: @escaping (Int) -> () ,onError: @escaping (String) -> ()) {
        onSuccess(10)
    }
    
    func getPeople(onSuccess: @escaping ([Person]) -> () ,onError: @escaping (String) -> ()) {
        var countOfPeople = 0
        getCountOfPeople { count in
            countOfPeople = count
        } onError: { error in
            onError(error)
            return
        }
        onSuccess(Array.init(repeating: Person(name: "Zhmyshenko Valera", height: 0, mass: 0, hair_color: "", scin_color: "", eye_color: "", birth_year: "", gender: "", homeworld: "", films: [], species: [], vehicles: [], starships: []), count: countOfPeople))
    }
    
}
