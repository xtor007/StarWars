//
//  PersonVC.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 26.04.2022.
//

import UIKit

class PersonVC: UIViewController {
    
    var data: Person!
    
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var skinLabel: UILabel!
    @IBOutlet weak var eyeLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var homeworldButton: UIButton!
    
    @IBOutlet weak var informationTable: UITableView!
    let cellId = "PersonCell"
    
    let sections = ["Films","Species","Vehicles","Starships"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        informationTable.delegate = self
        informationTable.dataSource = self
    }
    
    private func getData() {
        mainNameLabel.text = data.name
        nameLabel.text = data.name
        heightLabel.text = data.height
        massLabel.text = data.mass
        hairLabel.text = data.hair_color
        skinLabel.text = data.skin_color
        eyeLabel.text = data.eye_color
        birthYearLabel.text = data.birth_year
        genderLabel.text = data.gender
        homeworldButton.setTitle("Loading...", for: .normal)
        homeworldButton.setAttributedTitle(.init(string: "Loading...", attributes: [.font: UIFont(name: "Papyrus", size: 20)]), for: .normal)
    }

    @IBAction func backAction(_ sender: Any) {
    }
    
    @IBAction func goToHomeworldAction(_ sender: Any) {
    }
    
}

extension PersonVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
