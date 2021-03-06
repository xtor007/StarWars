//
//  PlanetVC.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 27.04.2022.
//

import UIKit

class PlanetVC: UIViewController {
    
    var data: Planet!
    
    var films: [Film?] = []
    var residents: [Person?] = []
    
    var indexPathForIgnore: [IndexPath] = []
    
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rotationLabel: UILabel!
    @IBOutlet weak var orbitalLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var terrainLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    @IBOutlet weak var informationTable: UITableView!
    let cellId = "PersonCell"
    let sections = ["Residents","Films"]

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        films = Array(repeating: nil, count: data.films.count)
        residents = Array(repeating: nil, count: data.residents.count)
        checkCach()
        informationTable.delegate = self
        informationTable.dataSource = self
    }
    
    private func checkCach() {
        for i in 0..<films.count {
            if let film = DataService.device.data[data.films[i]] as? Film {
                films[i] = film
            }
        }
        for i in 0..<residents.count {
            if let person = DataService.device.data[data.residents[i]] as? Person {
                residents[i] = person
            }
        }
    }
    
    private func getData() {
        mainNameLabel.text = data.name
        nameLabel.text = data.name
        rotationLabel.text = data.rotation_period
        orbitalLabel.text = data.orbital_period
        diameterLabel.text = data.diameter
        climateLabel.text = data.climate
        gravityLabel.text = data.gravity
        terrainLabel.text = data.terrain
        waterLabel.text = data.surface_water
        populationLabel.text = data.population
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismissDetail()
    }
    
}

extension PlanetVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return data.residents.count
            case 1: return data.films.count
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
                    if let person = residents[indexPath.row] {
                        cell.setName(person.name)
                    } else {
                        NetworkService.server.getPerson(withLink: data.residents[indexPath.row]) { person in
                            cell.setName(person.name)
                            self.residents[indexPath.row] = person
                            DataService.device.data[self.data.residents[indexPath.row]] = person
                        } onError: { message in
                            cell.setName("-")
                            self.showError(message) {
                                self.indexPathForIgnore.append(indexPath)
                            }
                        }
                    }
                case 1:
                    if let film = films[indexPath.row] {
                        cell.setName("Episode \(film.episode_id). \(film.title)")
                    } else {
                        NetworkService.server.getFilm(withLink: data.films[indexPath.row]) { film in
                            cell.setName("Episode \(film.episode_id). \(film.title)")
                            self.films[indexPath.row] = film
                            DataService.device.data[self.data.films[indexPath.row]] = film
                        } onError: { message in
                            cell.setName("-")
                            self.showError(message) {
                                self.indexPathForIgnore.append(indexPath)
                            }
                        }
                    }
                default: cell.setName("error")
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                if let person = residents[indexPath.row] {
                    if let personVC = storyboard?.instantiateViewController(withIdentifier: "personVC") as? PersonVC {
                        personVC.data = person
                        personVC.modalPresentationStyle = .fullScreen
                        presentDetail(personVC)
                    }
                }
            case 1:
                if let film = films[indexPath.row] {
                    if let filmVC = storyboard?.instantiateViewController(withIdentifier: "filmVC") as? FilmVC {
                        filmVC.data = film
                        filmVC.modalPresentationStyle = .fullScreen
                        presentDetail(filmVC)
                    }
                }
        default: showError("Something is not good") {}
        }
    }
    
}
