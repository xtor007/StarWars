//
//  CrawlVC.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 27.04.2022.
//

import UIKit

class CrawlVC: UIViewController {
    
    var text: String!

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
    }

}
