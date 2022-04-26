//
//  MainVC.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 25.04.2022.
//

import UIKit

class MainVC: UIViewController {
    
    let cellId = "PersonCell"
    
    var people: [Person] = []
    var count = 0
    
    @IBOutlet weak var peopleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTable.delegate = self
        peopleTable.dataSource = self
//        NetworkService.server.getPeople { people in
//            self.people = people
//            self.peopleTable.reloadData()
//        } onError: { error in
//            print(error)
//            //show
//        }
        NetworkService.server.getCountOfPeople { count in
            self.count = count
            self.peopleTable.reloadData()
        } onError: { message in
            print(message)
        }

    }

}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return people.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PesonCell {
            cell.setName("Loading...")
            NetworkService.server.getPerson(withIdentifire: indexPath.row+1) { person in
                cell.setName(person.name)
            } onError: { message in
                print(message)
                cell.setName("-")
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
