//
//  NavControllerCalculator.swift
//  iOS Calculator
//
//  Created by RicardoD on 27/9/22.
//

import UIKit

class NavControllerCalculator: UINavigationController {
    
    var myData: String!
    
    public override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if let vc = self.topViewController as? CalculatorViewController{
            vc.text = self.myData
            
        }
        
        
        /*if let vc = self.topViewController as? ProfileViewController{
            vc.user = self.myData
            
        }*/
    
    }
    

}
