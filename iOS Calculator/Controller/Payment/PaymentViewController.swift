//
//  PaymentViewController.swift
//  iOS Calculator
//
//  Created by RicardoD on 25/9/22.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    private var cards:[Card]?
    
    @IBOutlet var addMethodButton: UIButton!
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        viewLoadSetup()
        //createItem(hashCard: "Hola", typeCard: "test", price: 2)
        //viewWillAppear(true)
        /*tableView.dataSource = self
        tableView.delegate = self
        getAllItems()*/
        
        addMethodButton.round()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController()?.gestureEnabled = false
        viewLoadSetup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.gestureEnabled = true
    }
    
    func viewLoadSetup(){
        tableView.dataSource = self
        tableView.delegate = self
        getAllItems()
    }
    
    func getAllItems(){
        do{
        
            //let items = try context.fetch(Card.fetchRequest())
            
            self.cards = try context.fetch(Card.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            //tableView.reloadData()
        }
        catch{
            
            print("Error recuperando datos")
            
        }
    }
    
    func createItem(hashCard: String, typeCard: String, price: Float){
        let newItem = Card(context: self.context)
        newItem.createdAt = Date()
        newItem.hashCard = hashCard
        newItem.typeCard = typeCard
        newItem.price = price
        
        do{
            try self.context.save()
            self.getAllItems()
        } catch{
            print("Error creando item")
        }
        
    }
    
    func deleteItem(item: Card){
        context.delete(item)
        
        do{
            try context.save()
        } catch{
            print("Error borrando item")
            
        }
    }


}

extension PaymentViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
        
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 20)
        }
        
        cell!.textLabel?.text = cards![indexPath.row].typeCard
        
        return cell!
    }
}

extension PaymentViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(cards![indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Eliminar") {
            (action,view,completionHandler) in
            
            let cardDelete = self.cards![indexPath.row]
            
            self.context.delete(cardDelete)
            
            try! self.context.save()
            
            self.getAllItems()
        }
        
        return UISwipeActionsConfiguration(actions: [actionDelete])
    }
}






