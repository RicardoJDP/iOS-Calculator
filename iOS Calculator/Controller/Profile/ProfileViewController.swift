//
//  ProfileViewController.swift
//  iOS Calculator
//
//  Created by RicardoD on 14/9/22.
//

import UIKit

var profileUser: String?
class ProfileViewController: UIViewController {

    @IBOutlet var userLabel: UILabel!
    @IBOutlet var editProfileButton: UIButton!
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    var user: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        viewLoadSetup()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController()?.gestureEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.gestureEnabled = true
    }
    
    func viewLoadSetup(){
            
        editProfileButton.round()
        if loginUser != nil{
            profileUser = loginUser
            userLabel.text = loginUser
        }else{
            userLabel.text = "test"
        }

    }
    
    
}

