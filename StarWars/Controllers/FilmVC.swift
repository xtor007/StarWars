//
//  FilmVC.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 27.04.2022.
//

import UIKit

class FilmVC: UIViewController {
    
    var data: Film!
    
    var characters: [Person?] = []
    var planets: [Planet?] = []
    var starships: [Starship?] = []
    var vehicles: [Vehicle?] = []
    var species: [Speccy?] = []
    
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seeCrawlButton: UIButton!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var informationTable: UITableView!
    let cellId = "PersonCell"
    let sections = ["Characters","Planents","Starships","Vehicles","Species"]

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        characters = Array(repeating: nil, count: data.characters.count)
        planets = Array(repeating: nil, count: data.planets.count)
        starships = Array(repeating: nil, count: data.starships.count)
        vehicles = Array(repeating: nil, count: data.vehicles.count)
        species = Array(repeating: nil, count: data.species.count)
        informationTable.delegate = self
        informationTable.dataSource = self
    }
    
    func getData() {
        mainNameLabel.text = data.title
        nameLabel.text = "Episode \(data.episode_id). \(data.title)"
        seeCrawlButton.layer.cornerRadius = 20
        directorLabel.text = data.director
        producerLabel.text = data.producer
        dateLabel.text = data.release_date
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func seeCrawlAction(_ sender: Any) {
        print("See")
    }
    
}

extension FilmVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return data.characters.count
            case 1: return data.planets.count
            case 2: return data.starships.count
            case 3: return data.vehicles.count
            case 4: return data.species.count
            default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PersonCell {
            cell.setName("Loading...")
            switch indexPath.section {
            case 0:
                if let person = characters[indexPath.row] {
                    cell.setName(person.name)
                } else {
                    NetworkService.server.getPerson(withLink: data.characters[indexPath.row]) { person in
                        cell.setName(person.name)
                        self.characters[indexPath.row] = person
                    } onError: { message in
                        print(message)
                        cell.setName("-")
                    }
                }
            case 1:
                if let planet = planets[indexPath.row] {
                    cell.setName(planet.name)
                } else {
                    NetworkService.server.getPlanet(withLink: data.planets[indexPath.row]) { planet in
                        cell.setName(planet.name)
                        self.planets[indexPath.row] = planet
                    } onError: { message in
                        print(message)
                        cell.setName("-")
                    }
                }
            case 2:
                if let starship = starships[indexPath.row] {
                    cell.setName(starship.name)
                } else {
                    NetworkService.server.getStarship(withLink: data.starships[indexPath.row]) { starship in
                        cell.setName(starship.name)
                        self.starships[indexPath.row] = starship
                    } onError: { message in
                        print(message)
                        cell.setName("-")
                    }
                }
            case 3:
                if let vehicle = vehicles[indexPath.row] {
                    cell.setName(vehicle.name)
                } else {
                    NetworkService.server.getVehicle(withLink: data.vehicles[indexPath.row]) { vehicle in
                        cell.setName(vehicle.name)
                        self.vehicles[indexPath.row] = vehicle
                    } onError: { message in
                        print(message)
                        cell.setName("-")
                    }
                }
            case 4:
                if let speccy = species[indexPath.row] {
                    cell.setName(speccy.name)
                } else {
                    NetworkService.server.getSpeccy(withLink: data.species[indexPath.row]) { speccy in
                        cell.setName(speccy.name)
                        self.species[indexPath.row] = speccy
                    } onError: { message in
                        print(message)
                        cell.setName("-")
                    }
                }
            default:
                cell.setName("error")
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if let person = characters[indexPath.row] {
                if let personVC = storyboard?.instantiateViewController(withIdentifier: "personVC") as? PersonVC {
                    personVC.data = person
                    personVC.modalPresentationStyle = .fullScreen
                    presentDetail(personVC)
                }
            }
        case 1:
            if let planet = planets[indexPath.row] {
                if let planetVC = storyboard?.instantiateViewController(withIdentifier: "planetVC") as? PlanetVC {
                    planetVC.data = planet
                    planetVC.modalPresentationStyle = .fullScreen
                    presentDetail(planetVC)
                }
            }
        case 2:
            if let starship = starships[indexPath.row] {
                print(starship)
            }
        case 3:
            if let vehicle = vehicles[indexPath.row] {
                print(vehicle)
            }
        case 4:
            if let speccy = species[indexPath.row] {
                print(speccy)
            }
        default: print("error")
        }
    }
    
}
