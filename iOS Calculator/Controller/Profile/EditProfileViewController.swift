//
//  EditProfileViewController.swift
//  iOS Calculator
//
//  Created by RicardoD on 26/9/22.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet var userTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        userTF.placeholder = profileUser
        passwordTF.placeholder = "*******"
        userTF.text = ""
        passwordTF.text = ""
        
        saveButton.round()
        cancelButton.round()
    }
    

    @IBAction func cancelButtonAction(_ sender: Any) {
        userTF.text = ""
        passwordTF.text = ""
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        print("Entering to save button")
        
        if userTF.text == "" && passwordTF.text == ""{
            print("Error todo es nil")
            return
        }
            if userTF.text == ""{
            
                passwordUpdate(user: profileUser!, pass: passwordTF.text!)

            } else if passwordTF.text == ""{
                
                userUpdate(oldUser: profileUser!, user: userTF.text!, pass: getPassword(user: profileUser!))
                
                profileUser = userTF.text
                loginUser = userTF.text

            } else if userTF.text != "" && passwordTF.text != ""{
                print(profileUser!)
                print(userTF.text!)
                print(passwordTF.text!)
                itemUpdateAll(oldUser: profileUser!, user: userTF.text!, pass: passwordTF.text!)
                profileUser = userTF.text
                loginUser = userTF.text
            }

    }
    
    func userUpdate(oldUser: String, user: String, pass: String){
        do{
            try KeychainManager.updateUser(
                service: "test.com",
                oldUsername: oldUser,
                username: user,
                password: pass.data(using: .utf8) ?? Data()
            )

        }
        catch{
            print(error)
        }
    }
    
    func passwordUpdate(user: String, pass: String){
        do{
            try KeychainManager.updatePassword(
                service: "test.com",
                username: user,
                password: pass.data(using: .utf8) ?? Data()
            )

        }
        catch{
            print(error)
        }
    }
    
    func itemUpdateAll(oldUser:String, user: String, pass: String){
        do{
            try KeychainManager.updateCredentials(
                service: "test.com",
                oldUsername: oldUser,
                username: user,
                password: pass.data(using: .utf8) ?? Data()
            )

        }
        catch{
            print(error)
        }
    }
    
    func getPassword(user: String) -> String{

            guard let data = KeychainManager.getPassword(
                service: "test.com",
                 username: user
            )
            else{
                print("Failed to read password")
                return ""
            }
        
        let password = String(decoding: data, as: UTF8.self )
        print("Read password: \(password)")
        return password
    }
    
}
