//
//  AddPaymentViewController.swift
//  iOS Calculator
//
//  Created by RicardoD on 25/9/22.
//

import UIKit
import CryptoKit

class PaymentDataViewController: UIViewController {
    

    @IBOutlet var cardNumberField: UITextField!
    
    @IBOutlet var cardNumberError: UILabel!
    //@IBOutlet var cardNumberField: UITextField!
    @IBOutlet var cvvError: UILabel!
    
    @IBOutlet var confirmButton: UIButton!
    
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet var cardImage: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var dateField: UITextField!
    
    @IBOutlet var cvvField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    enum CardType: String {
        case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay

        static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]

        var regex : String {
            switch self {
            case .Amex:
               return "^3[47][0-9]{5,}$"
            case .Visa:
               return "^4[0-9]{6,}([0-9]{3})?$"
            case .MasterCard:
               return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
            case .Diners:
               return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
            case .Discover:
               return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
            case .JCB:
               return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
            case .UnionPay:
               return "^(62|88)[0-9]{5,}$"
            case .Hipercard:
               return "^(606282|3841)[0-9]{5,}$"
            case .Elo:
               return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
            default:
               return ""
            }
        }
    }
    
    private var cards:[Card]?
    
    var typeCardConfirm: String = ""
    let priceConfirm = 10
    var cardNumberBool: Bool = false
    var cvvNumberBool: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*print(luhnCheck(number: "5500000000000004")) //true
        print(luhnCheck(number: "348570250878868")) //true
        print(luhnCheck(number: "6011574229193127")) //false
        print(luhnCheck(number: "348570250872868")) //false
        print(luhnCheck(number: "4532307841419094")) //true
        
         
        print(validateCreditCardFormat(cardNumber: "1"))*/
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.orange

        //prefersStatusBarHidden = false
        resetForm()
        
        //confirmButton.isEnabled = false
        /*let result = validateCreditCardFormat(cardNumber: "4485389")
        
        let card = result.type
        let validate = result.valid
        
        print(card)
        print(validate)*/
        
        /*tableView.dataSource = self
        tableView.delegate = self*/
        
        /*getAllItems()*/
        
        //createItem(hashCard: valueToHash(value: "Hola"), typeCard: "test", price: 2)
        confirmButton.round()
        cancelButton.round()
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateField.inputView = datePicker
        dateField.text = formatDate(date: Date())
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        
        dateField.text = formatDate(date: datePicker.date)
        
    }
    
    func formatDate(date: Date) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    func valueToHash( value: String) -> String{
        let data = Data(value.utf8)
        let digest = SHA256.hash(data: data)
        let hash = digest.compactMap{String(format: "%02x", $0)}.joined()
        return(hash)
    }

    
    func createItem(hashCard: String, typeCard: String, price: Float){
        let newItem = Card(context: self.context)
        newItem.createdAt = Date()
        newItem.hashCard = hashCard
        newItem.typeCard = typeCard
        newItem.price = price
    
    }
    

    
    func resetForm(){
        
        confirmButton.isEnabled = false
        
        cardNumberField.isHidden = false
        cvvField.isHidden = false
        
        cardNumberError.text = "Required"
        cvvError.text = "Required"
        
        cardNumberField.text = ""
        cvvField.text = ""
    }
    
    
    @IBAction func cardChanged(_ sender: Any) {
        
        if let cardNumber = cardNumberField.text{
            if let errorMessage = invalidCardNumber(cardNumber)
            {
                cardNumberError.text = errorMessage
                cardNumberError.isHidden = false
                
                let creditCard = validateCreditCardFormat(cardNumber: cardNumber)
                print(creditCard.type)
                print(creditCard.valid)
                
                let stringCardType = String(creditCard.type)
                
                if stringCardType == "MasterCard"
                {
                    cardImage.image = UIImage(named: "masterCard")
                }
                else if stringCardType == "Visa"
                {
                    
                    cardImage.image = UIImage(named: "visaCard")
                }
                
                else if stringCardType == "Unknown"
                {
                    cardImage.image = UIImage(named: "unknownCard")

                }
                else
                {
                    cardImage.image = UIImage(named: "genericCard")

                }
                
                cardNumberBool = false
                
                confirmButton.isEnabled = false

            }
            else
            {
                let creditCard = validateCreditCardFormat(cardNumber: cardNumber)
                print(creditCard.type)
                
                let stringCardType = String(creditCard.type)
                
                if stringCardType == "MasterCard"
                {
                    cardImage.image = UIImage(named: "masterCard")
                }
                else if stringCardType == "Visa"
                {
                    
                    cardImage.image = UIImage(named: "visaCard")
                }
                
                else if stringCardType == "Unknown"
                {
                    cardImage.image = UIImage(named: "unknownCard")

                }
                else
                {
                    cardImage.image = UIImage(named: "genericCard")

                }
                
                typeCardConfirm = creditCard.type
                cardNumberError.text = " "
                
                if creditCard.valid == true && creditCard.type != "Unknown"{
                    cardNumberBool = true
                }else{
                    cardNumberBool = false
                }
                    
                
                if cardNumberBool == true && cvvNumberBool == true {
                    confirmButton.isEnabled = true
                }
            }
        }
    
    }
    
    func invalidCardNumber(_ value: String)-> String?{
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set)
        {
            return "Card Number must contain only digits"
        }
        
        if (value.count < 15 )
        {
            return "Card Number must be 15 or 16 Digits"
        }
        
        return nil
    }
    
    
    @IBAction func cvvChanged(_ sender: Any) {
        
        if let cvvNumber = cvvField.text{
            if let errorMessage = invalidCVV(cvvNumber)
            {
                cvvError.text = errorMessage
                cvvError.isHidden = false
                cvvNumberBool = false
                
                confirmButton.isEnabled = false
            }
            else
            {

                cvvError.text = " "
                cvvNumberBool = true
                
                if cardNumberBool == true && cvvNumberBool == true {
                    confirmButton.isEnabled = true
                }
                
                
            }
        }
    }
    
    func invalidCVV(_ value: String) -> String?{
        let set = CharacterSet(charactersIn: value)
        
        if !CharacterSet.decimalDigits.isSuperset(of: set)
        {
            
            return "Only digits"
        }
        
        if (value.count < 3 )
        {
            return "CVV 3 or 4 Digits"
        }
        
        return nil
        
        
        
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        if cardNumberBool == true && cvvNumberBool == true{
            createItem(hashCard: cardNumberField.text!, typeCard: typeCardConfirm, price: Float(priceConfirm))
            
            let alert = UIAlertController(title: "Card Registered Succesfully", message: "You payment has been processed, your card has been saved", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { ACTION in
                print("Card Registered")
            }))
            present(alert, animated: true)
            
            resetForm()
        }
    }

    @IBAction func cancelAction(_ sender: Any) {
        cardNumberField.text = ""
        cvvField.text = ""
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Validate Credit Card
    
    func validateCreditCardFormat(cardNumber: String)-> (type: CardType.RawValue, valid: Bool) {
            // Get only numbers from the input string
            //var input = self.text!
            //let numberOnly = input.stringByReplacingOccurrencesOfString("[^0-9]", withString: "", options: .RegularExpressionSearch)

        var type: CardType = .Unknown
        var formatted = ""
        var valid = false

        // detect card type
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: cardNumber)) {
                type = card
                break
            }
        }

        // check validity
        valid = luhnCheck(number: cardNumber)

        // format
        var formatted4 = ""
        for character in cardNumber {
            if formatted4.count == 4 {
                formatted += formatted4 + " "
                formatted4 = ""
            }
            formatted4.append(character)
        }

        formatted += formatted4 // the rest

        // return the tuple
        return (type.rawValue, valid)
    }

    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }

    func luhnCheck(number: String) -> Bool {
        var sum = 0
        let digitStrings = number.reversed().map { String($0) }

        for tuple in digitStrings.enumerated() {
            if let digit = Int(tuple.element){
                let odd = tuple.offset % 2 == 1

                switch (odd, digit) {
                case (true, 9):
                    sum += 9
                case (true, 0...8):
                    sum += (digit * 2) % 9
                default:
                    sum += digit
                }
            }else{
                    return false
                }
            }

        return sum % 10 == 0
    }
 
}

