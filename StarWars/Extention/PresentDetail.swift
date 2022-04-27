//
//  PresentDetail.swift
//  StarWars
//
//  Created by Anatoliy Khramchenko on 27.04.2022.
//

import UIKit

extension UIViewController {
    
    func presentDetail(_ toPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(toPresent, animated: false)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
}
