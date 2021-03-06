//
//  MainVC.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 25.04.2022.
//

import UIKit

class MainVC: UIViewController {
    
    let cellId = "PersonCell"
    
    var people: [Person?] = []
    var count = 0
    
    var indexPathForIgnore: [IndexPath] = []
    
    @IBOutlet weak var peopleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTable.delegate = self
        peopleTable.dataSource = self
        NetworkService.server.getCountOfPeople { count in
            self.count = count
            self.people = Array(repeating: nil, count: count)
            self.peopleTable.reloadData()
        } onError: { message in
            self.showError(message) {
                self.showError("You couldn't ignore this") {
                    self.dismiss(animated: false)
                }
            }
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return people.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PersonCell {
            cell.setName("Loading...")
            if indexPathForIgnore.contains(indexPath) {
                cell.setName("-")
                return cell
            }
            if let thisPerson = people[indexPath.row] {
                cell.setName(thisPerson.name)
            } else {
                NetworkService.server.getPerson(withIdentifire: indexPath.row+1) { person in
                    cell.setName(person.name)
                    self.people[indexPath.row] = person
                    DataService.device.data["https://swapi.dev/api/people/\(indexPath.row+1)"] = person
                } onError: { message in
                    cell.setName("-")
                    self.showError(message) {
                        self.indexPathForIgnore.append(indexPath)
                    }
                }
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let person = people[indexPath.row] {
            if let personVC = storyboard?.instantiateViewController(withIdentifier: "personVC") as? PersonVC {
                personVC.data = person
                personVC.modalPresentationStyle = .fullScreen
                presentDetail(personVC)
            }
        }
    }
    
}
