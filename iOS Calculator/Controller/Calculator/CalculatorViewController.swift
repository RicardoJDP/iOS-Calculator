//
//  MenuViewController.swift
//  iOS Calculator
//
//  Created by RicardoD on 14/9/22.
//

import AVKit
import UIKit

var menuUser:String?
class CalculatorViewController: UIViewController {
    
    

    @IBOutlet var calculatorView: UIView!
    //@IBOutlet var menuTableView: UITableView!
    //@IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    //@IBOutlet var swipeGestureRight: UISwipeGestureRecognizer!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    //@IBOutlet var labelResult: UILabel!
    var player: AVAudioPlayer?
    
    var text: String?
    
    var menu = false
    let screen = UIScreen.main.bounds
    var home = CGAffineTransform()
    

    
    /*var options: [option] = [
    
        option(title: "Profile", segue: "ProfileSegue"),
        option(title: "Payment", segue: "PaymentSegue"),
        option(title: "About Us", segue: "HomeSegue"),
        //option(title: "Log Out", segue: "mainSegue")
    ]
     
     


     override func viewDidLoad() {
         super.viewDidLoad()

     }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.revealViewController()?.gestureEnabled = false
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         self.revealViewController()?.gestureEnabled = true
     }
     
     
     
    
    struct option {
        var title = String()
        var segue = String()
        
    }*/
    
    //MARK: - Outlets
    
    //Result
    @IBOutlet weak var resultLabel: UILabel!
    
    
    //Numbers
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    
    
    //Operators
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorPercent: UIButton!
    @IBOutlet weak var operatorDiv: UIButton!
    @IBOutlet weak var operatorMulti: UIButton!
    @IBOutlet weak var operatorAdd: UIButton!
    @IBOutlet weak var operatorSubs: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    //MARK: - Variables
    private var total: Double = 0
    private var temp: Double = 0
    private var operating = false
    private var decimal = false
    private var operation: OperationType!
    
    private var currentTemp: String = ""
    
    private var auxBeforeDelete: String = ""

    
    //MARK: - Constantes
    
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kMaxValue: Double = 999999999
    private let kMinValue: Double = 0.00000001
    
    private enum OperationType {
        case none,
             addiction,
             substraction,
             multiplication,
             division,
             percent
    }
    
    
    
    //Formateo de valores auxiliar
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    //Formateo de valores por pantalla por defecto
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()

    @IBOutlet var viewResult: UIView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var cards:[Card]?
    
    var isLoadingViewController = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLoadingViewController = true
        
        /*menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.backgroundColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)*/
        
        
        home = calculatorView.transform
        
        viewLoadSetup()
        
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isLoadingViewController{
            isLoadingViewController = false
        } else{
            viewLoadSetup()
        }
        
        self.revealViewController()?.gestureEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.gestureEnabled = true
    }
    
    func viewLoadSetup(){
        
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        
        operatorAC.round()
        operatorPlusMinus.round()
        operatorPercent.round()
        operatorDiv.round()
        operatorMulti.round()
        operatorAdd.round()
        operatorSubs.round()
        operatorResult.round()
        numberDecimal.round()
        
        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
        

        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.direction = .right
        
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.direction = .left
        
        
        viewResult.addGestureRecognizer(swipeRight)
        viewResult.addGestureRecognizer(swipeLeft)
        
        swipeRight.addTarget(self, action: #selector(swipeRightDeleteDigit(sender:)))
        
        swipeLeft.addTarget(self, action: #selector(swipeLeftInsertDigit(sender:)))
        
        getAllItems()
        
        resultLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
        
        
    }
    
    func playVideo(){
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "videoCalculator", ofType: "mp4")!))
        
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true)
        
        /*let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        
        layer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(layer)
        player.volume = 0
        
        player.play()*/
    }
    
    func playMusic(){
        if let player = player, player.isPlaying{
            
            player.stop()
            print("Stoping...")
        }
        else {
            
            let urlString = Bundle.main.path(forResource: "audioCalculator", ofType: "mp3")
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else {
                    return
                }
                
                player.play()
                
                print("Playing..")
                
            }
            catch{
                print("Something went wrong with the music")
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text"{
            print("Old: ", change?[.oldKey])
            print("New: ", change?[.newKey])
            
            let comparatorValue = change?[.newKey]
           
            if (comparatorValue as! String == "3.14" || comparatorValue as! String == "3,14"){
                playMusic()
            } else if comparatorValue as! String == "333"{
                playVideo()
            }

        }
    }
    
    @objc func swipeRightDeleteDigit(sender:UISwipeGestureRecognizer){

        
        auxBeforeDelete = resultLabel.text!
        
        if resultLabel.text?.count == 1{
            
            resultLabel.text = "0"
            
            temp = 0
            currentTemp = ""
            
        }else {
        resultLabel.text = String(resultLabel.text!.dropLast())
        
        temp = Double(resultLabel.text!)!
        
        
        let aux2 = String(resultLabel.text!.dropLast())
            
        currentTemp = String(aux2)
        }

        //TEST
        /*let test = currentTemp
        resultLabel.text = String(test)
        
        let CT = test.dropLast()
        
        temp = Double(test)!
        
        currentTemp = String(CT)*/
        
    
        print("Right Gesture")
        
    }
    
    @objc func swipeLeftInsertDigit(sender:UISwipeGestureRecognizer){
      
            
            resultLabel.text = auxBeforeDelete
            
            temp = Double(resultLabel.text!)!
            
            let aux2 = String(resultLabel.text!.dropLast())
                
            currentTemp = String(aux2)
            
            print("Left Gesture")


        
    }
    
    
    func getAllItems(){
        do{
        
            //let items = try context.fetch(Card.fetchRequest())
            
            self.cards = try context.fetch(Card.fetchRequest())
            //tableView.reloadData()
            print("enter")
            if self.cards == [] {
                print("No cards register")
                
                operatorPercent.isEnabled = false
                operatorPlusMinus.isEnabled = false
                
            } else{
                print("Card(s) in core data")
                operatorPercent.isEnabled = true
                operatorPlusMinus.isEnabled = true
                
            }
        }
        catch{
            
            print("Error recuperando datos")
            
        }
    }
    
    /*func showMenu(){
        
        self.calculatorView.layer.cornerRadius = 40
        //self.viewBG.layer.cornerRadius = self.calculatorView.layer.cornerRadius
        let x = screen.width * 0.8
        let originalTransform = self.calculatorView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
        UIView.animate(withDuration: 0.7, animations: {
            self.calculatorView.transform = scaledAndTranslatedTransform
        })
    }
    
     
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        
        if menu == false && swipeGesture.direction == .right {
            showMenu()
            menu = true
        }
    }
    
    func hideMenu(){
        
        UIView.animate(withDuration: 0.7){
            self.calculatorView.transform = self.home
            self.calculatorView.layer.cornerRadius = 0
            self.calculatorView.layer.cornerRadius =
                self.calculatorView.layer.cornerRadius
        }
    }
    
    @IBAction func hideMenu(_ sender: Any) {
        
        if menu == true{
            
            hideMenu()
            menu = false
        }
    }*/
    
    //MARK: - Button Action
    
    
    @IBAction func operatorACAction(_ sender: UIButton) {
        
        clear()
        operatorAC.shine()
    }
    
    @IBAction func operatorPlusMinusAction(_ sender: UIButton) {
        
        temp = temp * (-1)
        
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        operatorPlusMinus.shine()
    }
    
    @IBAction func operatorPercentAction(_ sender: UIButton) {
        
        if operation != .percent {
            result()
        }
        operating = true
        operation = .percent
        result()
        
        operatorPercent.shine()
    }
    
    @IBAction func operatorDivAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .division
        operatorDiv.shine()
    }
    
    @IBAction func operatorMultiAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .multiplication
        operatorMulti.shine()
    }
    
    @IBAction func operatorAddAction(_ sender: UIButton) {
        
        result()
        operating = true
        operation = .addiction
        
        operatorAdd.shine()
    }
    
    @IBAction func operatorSubsAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .substraction
        
        operatorSubs.shine()
    }

    @IBAction func operatorResultAction(_ sender: UIButton) {
        
        result()
        
        operatorResult.shine()
        
    }
    
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        
        let currentTemp = auxFormatter.string(from: NSNumber(value:temp))!
        if !operating && currentTemp.count >= kMaxLength{
            return
        }
        
        resultLabel.text = resultLabel.text! + kDecimalSeparator
        
        print(resultLabel.text)
        
        //currentTempGlobal = String(resultLabel.text!)
        
        decimal = true
        
        numberDecimal.shine()
    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        
        operatorAC.setTitle("C", for: .normal)
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count >= kMaxLength{
            return
        }
        
        if operating{
            total = total == 0 ? temp:total
            resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        let number = sender.tag
        print("CurrentTemp: ", currentTemp)
        //print("CurrentTemp: ", Double(currentTemp)!)
        
        //currentTempGlobal = currentTemp
        /*tempGlobal = temp
        resultLabelGlobal = resultLabel.text ?? "default value"*/
        //tempGlobal = (currentTemp + String(number))
        //print("TempG: ", tempGlobal)
        temp = Double(currentTemp + String(number))!
        //temp = ridZero(result: currentTemp + String(number))
        print("Temp: ", temp)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        print("ResultLabe: ", resultLabel.text ?? "hola")
        print("Tag: ", sender.tag)
        
        sender.shine()
    }
    //RIDZERO
    private func ridZero(result:String) -> String {
        let value = String(format: "%g", result)
        return value
    }
    
    
    private func clear(){
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        }else {
            total = 0
        }
    }
    
    private func result(){
        
        switch operation{
        
        case .none:
            break
        case .addiction:
            total = total + temp
            break
        case .substraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            total = temp / 100
            total = temp
            break
    
        case .some(.none):
            break
        }
        if total <= kMaxValue || total >= kMinValue {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        print("Total: \(total)")
    }
    
}

/*extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! tableViewCell
        cell.backgroundColor = .clear
        cell.descriptionLabel.text = options[indexPath.row].title
        //cell.descriptionLabel.textColor = white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell
            
            currentCell.alpha = 0.5
            UIView.animate(withDuration: 1) {
                currentCell.alpha = 1
            }
            

            
            self.parent?.performSegue(withIdentifier: options[indexPath.row].segue  , sender: self)
            
        }
    }
    
}

class tableViewCell: UITableViewCell {
    
    
    @IBOutlet var descriptionLabel: UILabel!
    
    
}*/


