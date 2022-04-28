//
//  SpeccyVC.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 27.04.2022.
//

import UIKit

class SpeccyVC: UIViewController {
    
    var data: Speccy!
    
    var planet: Planet?
    var people: [Person?] = []
    var films: [Film?] = []
    
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var skinLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var eyeLabel: UILabel!
    @IBOutlet weak var lifespanLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var homeworldButton: UIButton!
    @IBOutlet weak var designationLabel: UILabel!
    
    @IBOutlet weak var informationTable: UITableView!
    let cellId = "PersonCell"
    let sections = ["People","Films"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        people = Array(repeating: nil, count: data.people.count)
        films = Array(repeating: nil, count: data.films.count)
        informationTable.delegate = self
        informationTable.dataSource = self
    }
    
    private func getData() {
        mainNameLabel.text = data.name
        nameLabel.text = data.name
        classificationLabel.text = data.classification
        designationLabel.text = data.designation
        heightLabel.text = data.average_height
        skinLabel.text = data.skin_colors
        hairLabel.text = data.hair_colors
        eyeLabel.text = data.eye_colors
        lifespanLabel.text = data.average_lifespan
        if let homeworld = data.homeworld {
            setTitleHomeworldButton("Loading...")
            NetworkService.server.getPlanet(withLink: homeworld) { planet in
                self.planet = planet
                self.setTitleHomeworldButton(planet.name)
            } onError: { message in
                print(message)
            }
        } else {
            setTitleHomeworldButton("none")
        }
    }
    
    private func setTitleHomeworldButton(_ title: String) {
        homeworldButton.setTitle(title, for: .normal)
        homeworldButton.setAttributedTitle(.init(string: title, attributes: [.font: UIFont(name: "Papyrus", size: 20)]), for: .normal)
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func goToHomeworldAction(_ sender: Any) {
        if let planet = planet {
            if let planetVC = storyboard?.instantiateViewController(withIdentifier: "planetVC") as? PlanetVC {
                planetVC.data = planet
                planetVC.modalPresentationStyle = .fullScreen
                presentDetail(planetVC)
            }
        }
    }
    
}

extension SpeccyVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return data.people.count
        case 1: return data.films.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PersonCell {
            cell.setName("Loading...")
            switch indexPath.section {
            case 0:
                if let person = people[indexPath.row] {
                    cell.setName(person.name)
                } else {
                    NetworkService.server.getPerson(withLink: data.people[indexPath.row]) { person in
                        cell.setName(person.name)
                        self.people[indexPath.row] = person
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
            if let person = people[indexPath.row] {
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
        default:
            print("error")
        }
    }
    
}
