//
//  AboutUsViewController.swift
//  iOS Calculator
//
//  Created by RicardoD on 9/10/22.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet var iconApp: UIImageView!
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconApp.layer.cornerRadius = 20
        iconApp.layer.borderWidth = 1

        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController()?.gestureEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.gestureEnabled = true
    }

    


}

