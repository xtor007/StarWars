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
    
    var indexPathForIgnore: [IndexPath] = []
    
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
        checkCach()
        informationTable.delegate = self
        informationTable.dataSource = self
    }
    
    private func checkCach() {
        for i in 0..<characters.count {
            if let person = DataService.device.data[data.characters[i]] as? Person {
                characters[i] = person
            }
        }
        for i in 0..<planets.count {
            if let planet = DataService.device.data[data.planets[i]] as? Planet {
                planets[i] = planet
            }
        }
        for i in 0..<species.count {
            if let speccy = DataService.device.data[data.species[i]] as? Speccy {
                species[i] = speccy
            }
        }
        for i in 0..<vehicles.count {
            if let vehicle = DataService.device.data[data.vehicles[i]] as? Vehicle {
                vehicles[i] = vehicle
            }
        }
        for i in 0..<starships.count {
            if let starship = DataService.device.data[data.starships[i]] as? Starship {
                starships[i] = starship
            }
        }
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
        if let crawlVC = storyboard?.instantiateViewController(withIdentifier: "crawlVC") as? CrawlVC {
            crawlVC.text = data.opening_crawl
            present(crawlVC, animated: true)
        }
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
            if indexPathForIgnore.contains(indexPath) {
                cell.setName("-")
                return cell
            }
            switch indexPath.section {
            case 0:
                if let person = characters[indexPath.row] {
                    cell.setName(person.name)
                } else {
                    NetworkService.server.getPerson(withLink: data.characters[indexPath.row]) { person in
                        cell.setName(person.name)
                        self.characters[indexPath.row] = person
                        DataService.device.data[self.data.characters[indexPath.row]] = person
                    } onError: { message in
                        cell.setName("-")
                        self.showError(message) {
                            self.indexPathForIgnore.append(indexPath)
                        }
                    }
                }
            case 1:
                if let planet = planets[indexPath.row] {
                    cell.setName(planet.name)
                } else {
                    NetworkService.server.getPlanet(withLink: data.planets[indexPath.row]) { planet in
                        cell.setName(planet.name)
                        self.planets[indexPath.row] = planet
                        DataService.device.data[self.data.planets[indexPath.row]] = planet
                    } onError: { message in
                        cell.setName("-")
                        self.showError(message) {
                            self.indexPathForIgnore.append(indexPath)
                        }
                    }
                }
            case 2:
                if let starship = starships[indexPath.row] {
                    cell.setName(starship.name)
                } else {
                    NetworkService.server.getStarship(withLink: data.starships[indexPath.row]) { starship in
                        cell.setName(starship.name)
                        self.starships[indexPath.row] = starship
                        DataService.device.data[self.data.starships[indexPath.row]] = starship
                    } onError: { message in
                        cell.setName("-")
                        self.showError(message) {
                            self.indexPathForIgnore.append(indexPath)
                        }
                    }
                }
            case 3:
                if let vehicle = vehicles[indexPath.row] {
                    cell.setName(vehicle.name)
                } else {
                    NetworkService.server.getVehicle(withLink: data.vehicles[indexPath.row]) { vehicle in
                        cell.setName(vehicle.name)
                        self.vehicles[indexPath.row] = vehicle
                        DataService.device.data[self.data.vehicles[indexPath.row]] = vehicle
                    } onError: { message in
                        cell.setName("-")
                        self.showError(message) {
                            self.indexPathForIgnore.append(indexPath)
                        }
                    }
                }
            case 4:
                if let speccy = species[indexPath.row] {
                    cell.setName(speccy.name)
                } else {
                    NetworkService.server.getSpeccy(withLink: data.species[indexPath.row]) { speccy in
                        cell.setName(speccy.name)
                        self.species[indexPath.row] = speccy
                        DataService.device.data[self.data.species[indexPath.row]] = speccy
                    } onError: { message in
                        cell.setName("-")
                        self.showError(message) {
                            self.indexPathForIgnore.append(indexPath)
                        }
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
                if let starshipVC = storyboard?.instantiateViewController(withIdentifier: "starshipVC") as? StarshipVC {
                    starshipVC.data = starship
                    starshipVC.modalPresentationStyle = .fullScreen
                    presentDetail(starshipVC)
                }
            }
        case 3:
            if let vehicle = vehicles[indexPath.row] {
                if let vehicleVC = storyboard?.instantiateViewController(withIdentifier: "vehicleVC") as? VehicleVC {
                    vehicleVC.data = vehicle
                    vehicleVC.modalPresentationStyle = .fullScreen
                    presentDetail(vehicleVC)
                }
            }
        case 4:
            if let speccy = species[indexPath.row] {
                if let speccyVC = storyboard?.instantiateViewController(withIdentifier: "speccyVC") as? SpeccyVC {
                    speccyVC.data = speccy
                    speccyVC.modalPresentationStyle = .fullScreen
                    presentDetail(speccyVC)
                }
            }
        default: showError("Something is not good") {}
        }
    }
    
}
