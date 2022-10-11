//
//  UIButtonExtension.swift
//  iOS Calculator
//
//  Created by RicardoD on 12/9/22.
//

import UIKit

extension UIButton{
    
    //Borde redondo
    
    func round(){
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    //Brillo
    
    func shine(){
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
        
    }
    
    func round_shadow(){
        layer.cornerRadius = bounds.height / 2
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowPath = nil
    }
    
}
