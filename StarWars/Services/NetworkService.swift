//
//  NetworkService.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 25.04.2022.
//

import Foundation

class NetworkService {
    
    static let server = NetworkService()
    
    let URL_BASIC = "https://swapi.dev/api"
    let URL_PEOPLE = "/people"
    
    let session = URLSession(configuration: .default)
    
    func getCountOfPeople(onSuccess: @escaping (Int) -> () ,onError: @escaping (String) -> ()) {
        guard let url = URL(string: "\(URL_BASIC)\(URL_PEOPLE)") else {
            onError("Failed link")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(People.self, from: data)
                        onSuccess(result.count)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError("\(err.debug.status) \(err.debug.statusText)")
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getPerson(withIdentifire id: Int, onSuccess: @escaping (Person) -> () ,onError: @escaping (String) -> ()) {
        guard let url = URL(string: "\(URL_BASIC)\(URL_PEOPLE)/\(id)") else {
            onError("Failed link")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Person.self, from: data)
                        onSuccess(result)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError("\(err.debug.status) \(err.debug.statusText)")
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getPerson(withLink link: String, onSuccess: @escaping (Person) -> () ,onError: @escaping (String) -> ()) {
        guard let url = URL(string: link) else {
            onError("Failed link")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Person.self, from: data)
                        onSuccess(result)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError("\(err.debug.status) \(err.debug.statusText)")
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getPlanet(withLink link: String, onSuccess: @escaping (Planet) -> () ,onError: @escaping (String) -> ()) {
        guard let url = URL(string: link) else {
            onError("Failed link")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Planet.self, from: data)
                        onSuccess(result)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError("\(err.debug.status) \(err.debug.statusText)")
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getFilm(withLink link: String, onSuccess: @escaping (Film) -> () ,onError: @escaping (String) -> ()) {
        guard let url = URL(string: link) else {
            onError("Failed link")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Film.self, from: data)
                        onSuccess(result)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError("\(err.debug.status) \(err.debug.statusText)")
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getSpeccy(withLink link: String, onSuccess: @escaping (Speccy) -> () ,onError: @escaping (String) -> ()) {
        guard let url = URL(string: link) else {
            onError("Failed link")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Speccy.self, from: data)
                        onSuccess(result)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError("\(err.debug.status) \(err.debug.statusText)")
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getVehicle(withLink link: String, onSuccess: @escaping (Vehicle) -> () ,onError: @escaping (String) -> ()) {
        guard let url = URL(string: link) else {
            onError("Failed link")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Vehicle.self, from: data)
                        onSuccess(result)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError("\(err.debug.status) \(err.debug.statusText)")
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getStarship(withLink link: String, onSuccess: @escaping (Starship) -> () ,onError: @escaping (String) -> ()) {
        guard let url = URL(string: link) else {
            onError("Failed link")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Starship.self, from: data)
                        onSuccess(result)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError("\(err.debug.status) \(err.debug.statusText)")
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
//    func getPeople(onSuccess: @escaping ([Person]) -> () ,onError: @escaping (String) -> ()) {
//        getCountOfPeople { count in
//            var result: [Person] = []
//            for i in 1...count {
//                self.getPerson(withIdentifire: i) { person in
//                    result.append(person)
//                    if result.count == count {
//                        onSuccess(result)
//                    }
//                } onError: { error in
//                    onError(error)
//                }
//            }
//        } onError: { error in
//            onError(error)
//            return
//        }
//    }
    
}
