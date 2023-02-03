//
//  ViewController.swift
//  ProyectoSideMenuMapas
//
//  Created by estech on 19/1/23.
//

import UIKit
import SWRevealViewController

class ViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureMainMenu(menuButton: menuButton)
    }

}


extension UIViewController {
    func configureMainMenu(menuButton: UIBarButtonItem) {
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 276
        }
    }
    
    func configureRightMenu(rightButton: UIBarButtonItem) {
        if revealViewController() != nil {
            //Configuramos menú derecho
            rightButton.target = revealViewController()
            rightButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            revealViewController()?.rightViewRevealWidth = 160
        }
    }
    
}
