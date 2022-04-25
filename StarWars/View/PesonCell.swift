//
//  PesonCell.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 25.04.2022.
//

import UIKit

class PesonCell: UITableViewCell {
    
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setName(_ name: String) {
        self.name.text = name
    }
    
}
