//
//  LoginViewController.swift
//  iOS Calculator
//
//  Created by RicardoD on 21/9/22.
//

var loginUser:String?
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var imageCircle: UIImageView!
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    public var publicUser: String?
    
    var iconClick = false
    let imageIcon = UIImageView()

    
   
    
    var enableLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let swift_color = UIColor(red: 51, green: 51, blue: 51, alpha: 1).cgColor
        /*imageCircle.backgroundColor = .darkGray
        imageCircle.layer.masksToBounds = true
        imageCircle.layer.cornerRadius = imageCircle.frame.height / 2
        imageCircle.layer.borderColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.1).cgColorƒ
        imageCircle.layer.borderWidth = 25*/
        //imageCircle.layer.borderColor = UIColor.darkGray.cgColor
        
        loginButton.round()
        
        userTextField.text = ""
        passwordTextField.text = ""
        
        passwordTextField.isSecureTextEntry = true
        
        //NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("text"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("text"), object: passwordTextField.text)

        /*deleteCredentials(user: "ricardo")
        deleteCredentials(user: "javier")
        deleteCredentials(user: "javierito")
        deleteCredentials(user: "")
        deleteCredentials(user: "ricardodo")
        deleteCredentials(user: "javierito")
        deleteCredentials(user: "ricardito")*/
        
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
    

    
    /*func getUser(user: String, pass: String) -> String{

        guard let data = KeychainManager.getPassword(
                service: "test.com",
                 username: user//,
                //password: "pass".data(using: .utf8) ?? Data()
                )
            else{
                print("Failed to read password")
                return ""
            }
        
        let user = String(decoding: data, as: UTF8.self )
        print("Read password: \(user)")
        return user
    }*/
    
    func existCredentials(user: String, pass: String) -> Bool{
        
        guard let data = KeychainManager.getKeyChain(
                service: "test.com",
                username: user,
                password: pass.data(using: .utf8) ?? Data()
                )
            else{
                print("Failed to read password")
                return false
            }
        
        
        let password = String(decoding: data, as: UTF8.self )
        print("Read password: \(password)")
        
        if pass != password{
            return false
        }
        return true
        
    }
    
    func deleteCredentials(user: String){
            do
                {try KeychainManager.delete(
                    service: "test.com",
                    username: user//,
                    //*password: "pass".data(using: .utf8) ?? Data()
                    )
                }
                catch{
                    print(error)

                }
            print("Deleted username: \(user)")
    }
    

    //MARK: - Actions in the LoginViewController
    
    @IBAction func loginButttonAction(_ sender: Any) {
        let user = userTextField.text
        let pass = passwordTextField.text
        let credentialSearch = existCredentials(user: user!, pass: pass!)
        
        if credentialSearch {
            enableLogin = true
            

            
            /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "navControllerCalculator")
            loadViewIfNeeded()
            show(secondVC, sender: self)*/
            
            //calVc
            
            //navControllerCalculator
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            
            
            /*let thirdVc = storyboard.instantiateViewController(withIdentifier: "calVc") as! MenuViewController
            thirdVc.text = userTextField.text*/
            
            let secondVc = storyboard.instantiateViewController(withIdentifier: "MainViewID") as! MainViewController
            //secondVc.
            //let navController = storyboard.instantiateViewController(identifier: "navControllerCalculator")
            loginUser = userTextField.text
            //secondVc.myData = userTextField.text
            secondVc.modalPresentationStyle = .fullScreen
            
            present(secondVc, animated: true, completion: nil)
            //self.navigationController?.pushViewController(secondVc, animated: true)
            

        }else{
            let alert = UIAlertController(title: "No User Found", message: "Your account has noot been registered or the credentials are incorrect", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { ACTION in
                print("User Not found")
            }))
            present(alert, animated: true)
        }
    }
    
    
    //MARK: - PREGUNTARLE A SHIFU
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "testSegue"{
            let navController = segue.destination as! UINavigationController
            let detailController = navController.topViewController as! CalculatorViewController
            detailController.text = userTextField.text!
        }
    }
    
    
}
