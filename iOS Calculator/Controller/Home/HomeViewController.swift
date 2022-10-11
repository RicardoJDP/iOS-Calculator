//
//  MainViewController.swift
//  iOS Calculator
//
//  Created by RicardoD on 21/9/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var navController: UINavigationItem!
    @IBOutlet var imageCircle: UIImageView!
    @IBOutlet var imageRectangle: UIImageView!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var viewRectangle: UIView!
    @IBOutlet var viewCircle: UIView!
    @IBOutlet var iconApp: UIImageView!
    
    @IBOutlet var viewIconApp: UIView!
    
    /*override var prefersStatusBarHidden: Bool{
        return true
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let swift_color = UIColor(red: 51, green: 51, blue: 51, alpha: 1).cgColor
    
        /*imageCircle.backgroundColor = .black
        imageCircle.layer.masksToBounds = true
        imageCircle.layer.cornerRadius = imageCircle.frame.height / 2
        
        imageRectangle.backgroundColor = .darkGray
        imageRectangle.layer.masksToBounds = true
        
        imageRectangle.layer.masksToBounds = false*/
        iconApp.layer.cornerRadius = 20
        iconApp.layer.borderWidth = 1
        
        /*viewRectangle.backgroundColor = UIColor.init(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        
        
        viewCircle.layer.cornerRadius = 10
        viewCircle.layer.borderWidth = 3*/
        
        /*viewIconApp.layer.cornerRadius = 10
        viewIconApp.layer.borderWidth = 3*/
        /*viewCircle.layer.cornerRadius = viewCircle.frame.height / 2
        viewCircle.backgroundColor = .black*/
        /*imageRectangle.layer.borderColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor*/
        /*imageCircle.layer.borderColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        imageCircle.layer.borderWidth = 25*/
        
        //self.modalPresentationStyle = .fullScreen
        loginButton.round_shadow()
        
        //navigationController?.navigationBar.barTintColor = UIColor.black
        //navigationController?.navigationBar.barTintColor = .white
        UINavigationBar.appearance().barTintColor = .black
        
         //UINavigationBar.statusbar
        
        //loginButton.round()
        //loginButton.shadow()
        
        //navigationController.hide = true
        //imageCircle.layer.borderColor = UIColor.darkGray.cgColor
    }
        



}



