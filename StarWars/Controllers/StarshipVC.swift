//
//  StarshipVC.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 28.04.2022.
//

import UIKit

class StarshipVC: UIViewController {
    
    var data: Starship!
    
    var pilots: [Person?] = []
    var films: [Film?] = []
    
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var passengersLabel: UILabel!
    @IBOutlet weak var cargoCapacityLabel: UILabel!
    @IBOutlet weak var consumablesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var mgltLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    
    @IBOutlet weak var informationTable: UITableView!
    let cellId = "PersonCell"
    let sections = ["Pilots","Films"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        pilots = Array(repeating: nil, count: data.pilots.count)
        films = Array(repeating: nil, count: data.films.count)
        informationTable.dataSource = self
        informationTable.delegate = self
    }
    
    private func getData() {
        mainNameLabel.text = data.name
        nameLabel.text = data.name
        modelLabel.text = data.model
        manufacturerLabel.text = data.manufacturer
        costLabel.text = data.cost_in_credits
        lengthLabel.text = data.length
        speedLabel.text = data.max_atmosphering_speed
        crewLabel.text = data.crew
        passengersLabel.text = data.passengers
        cargoCapacityLabel.text = data.cargo_capacity
        consumablesLabel.text = data.consumables
        ratingLabel.text = data.hyperdrive_rating
        mgltLabel.text = data.MGLT
        classLabel.text = data.starship_class
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismissDetail()
    }
    
}

extension StarshipVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return data.pilots.count
            case 1: return data.films.count
            default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PersonCell {
            cell.setName("Loading...")
            switch indexPath.section {
                case 0:
                    if let person = pilots[indexPath.row] {
                        cell.setName(person.name)
                    } else {
                        NetworkService.server.getPerson(withLink: data.pilots[indexPath.row]) { person in
                            cell.setName(person.name)
                            self.pilots[indexPath.row] = person
                        } onError: { message in
                            print(message)
                            cell.setName("-")
                        }
                    }
                case 1:
                    if let film = films[indexPath.row] {
                        cell.setName("Episode \(film.episode_id). \(film.title)")
                    } else {
                        NetworkService.server.getFilm(withLink: data.films[indexPath.row]) { film in
                            cell.setName("Episode \(film.episode_id). \(film.title)")
                            self.films[indexPath.row] = film
                        } onError: { message in
                            print(message)
                            cell.setName("-")
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
                if let person = pilots[indexPath.row] {
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
            default: print("error")
        }
    }
    
}
