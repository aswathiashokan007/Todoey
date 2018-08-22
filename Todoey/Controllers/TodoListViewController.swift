//
//  ViewController.swift
//  Todoey
//
//  Created by IOS Developer on 21/08/18.
//  Copyright © 2018 Softland India Limited. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
   // var itemArray = ["Test1" ,"Test2" , "Test3"]
    var itemArray  = [Item]()
    
    let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    let defaults = UserDefaults.standard // to make app default and std
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view, typically from a nib.
        
        // datastore path singleton object - important
        /*let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        print(dataPath)*/
        
       // print(dataPath)
        
        
        
        /*let newItem = Item()
        newItem.title = "Test1"
        //newItem.done  = true
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Test2"
         itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Test3"
         itemArray.append(newItem3)*/
        
        //used   loadItems()  for this purpose
        
        
       // if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
         //   itemArray = items
        //}
        
        loadItems()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK 1- TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCell")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        //cell.textLabel?.text = itemArray[indexPath.row]
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType =  item.done ? .checkmark : .none
        
       /*if item.done == true {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }*/
        
        return cell
    }
    
    
    //MARK -2 TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        
        //to add check mark for selected row
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done // check mark checking
        
        /*if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }else {
            itemArray[indexPath.row].done = false
        }*/
        //tableView.reloadData() // app run time checkmark not come properly to fix this add reloadData()
        
        saveItems() // it consist tableView.reloadData()
        
        /*if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }*/
        
        
        
        //to hide selected row color change to add
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK-2 : Add new item methods
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // button click action
          
            
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            
            self.saveItems()
            
            
            
            
           // self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
           // to show current added data to tableview grid - device
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            //print(alertTextField.text)
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do
        {
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataPath!)
        }
        catch
        {
            print("Error\(error)")
        }
         self.tableView.reloadData()
    }
    
    
    func loadItems(){ // load items from Items.plist ,ratherthan hardcoded details
        
        if let data = try? Data(contentsOf: dataPath!) {
            let decoder = PropertyListDecoder()
            do
            {
             itemArray = try decoder.decode([Item].self, from: data)
                
                print(itemArray)
            }
            catch
            {
                print("error\(error)")
            }
        }
        
        
        
    }
    
}

