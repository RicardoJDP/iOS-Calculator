//
//  RegisterViewController.swift
//  iOS Calculator
//
//  Created by RicardoD on 21/9/22.
//

import UIKit
//mport KeyChainManager

class RegisterViewController: UIViewController {

    @IBOutlet var imageCircle: UIImageView!
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var viewPrincipal: UIView!
    
    var iconClick = false
    let imageIcon = UIImageView()
    
    var showingAlert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let swift_color = UIColor(red: 51, green: 51, blue: 51, alpha: 1).cgColor
        /*imageCircle.backgroundColor = .darkGray
        imageCircle.layer.masksToBounds = true
        imageCircle.layer.cornerRadius = imageCircle.frame.height / 2
        imageCircle.layer.borderColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        imageCircle.layer.borderWidth = 25*/
        //imageCircle.layer.borderColor = UIColor.darkGray.cgColor
        
        //delete()
        /*let pass = getPassword()
        passwordTextField.text = pass
        
        itemUpdate()
        //usernameTextField.text = getName()
        let pass2 = getPassword()
        passwordTextField.text = pass2*/
        /*do{
            try KeychainManager.save(
                service: "test.com" ,
                username: "ric",
                password: "password".data(using: .utf8) ?? Data()
            )
        }
        catch{
            print(error)
        }*/
        //viewPrincipal.backgroundColor = UIColor.init(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        
        registerButton.round()
        usernameTextField.text = ""
        passwordTextField.text = ""
    
        passwordTextField.isSecureTextEntry = true
    
        imageIcon.image = UIImage(named: "eyeClose")
        
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
        
        imageIcon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
        
        }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if iconClick{
            iconClick = false
            tappedImage.image = UIImage(named: "eyeOpen")
            passwordTextField.isSecureTextEntry = false
        }
        else{
            iconClick = true
            tappedImage.image = UIImage(named: "eyeClose")
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    func getPassword(user: String) -> String{

            guard let data = KeychainManager.getPassword(
                service: "test.com",
                username: user
            )
            else{
                print("Failed to find user with password")
                return ""
            }
        
        let password = String(decoding: data, as: UTF8.self )
        //print("Read password: \(password)")
        return password
    }
    
    /*func getUser(user: String) -> Bool{
        
        var userExist = false
        let auxUser = KeychainManager.getUser(
            service: "test.com",
            username: user
        )
        
        let userValidate = String(decoding: auxUser ?? <#default value#>, as: UTF8.self)
        if auxUser{
            print("User already exist")
            userExist = true
            return userExist
        }
        else{
            userExist = false
            return userExist
        }
        
    }*/
    
    func save(user: String,  pass:  String){
        do{
            try KeychainManager.save(
                service: "test.com" ,
                username: user,
                password: pass.data(using: .utf8) ?? Data()
            )
        }
        catch{
            print(error)
        }
    }
    
    func itemUpdate(){
        do{
            try KeychainManager.updatePassword(
                service: "test.com",
                username: "ric",
                password: "password4".data(using: .utf8) ?? Data()
            )
        }
        catch{
            print(error)
        }
    }
    /*func itemPudate(
        _ query: CFDictionary,
        _ attributesToUpdate: CFDictionary
    ) -> OSStatus{}*/
    
    func delete(){
        do{
            try KeychainManager.delete(
                service: "test.com",
                username: "ric")
        }
        catch{
            print(error)
        }
    }

    @IBAction func registerButtonAction(_ sender: Any) {
        
        if usernameTextField.text == "" || passwordTextField.text == ""{
            let alert = UIAlertController(title: "Missing fields", message: "You need to fill all the fields when you register", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { ACTION in
                print("Missing datos")
            }))
            
            present(alert, animated: true)
        }
        else if getPassword(user: usernameTextField.text!) != "" {
                
                let alert = UIAlertController(title: "Duplicate User", message: "The user that you're trying to register alredy exist, try another", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { ACTION in
                    print("Duplicate User")
                }))
                present(alert, animated: true)
            usernameTextField.text = ""
            passwordTextField.text = ""
            
        }else if usernameTextField.text != "" && passwordTextField.text != ""{
            save(user: String(usernameTextField.text!), pass: String(passwordTextField.text!))
            
            let alert = UIAlertController(title: "Successful Registration ", message: "Your account has been registered", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { ACTION in
                print("Registration hecha")
            }))
            present(alert, animated: true)


        }
        
    }
    
}


