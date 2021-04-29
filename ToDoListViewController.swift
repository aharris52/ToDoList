//
//  ViewController.swift
//  Todoey
//
//  Companion Project for iOS coursework
//  @Author Andrew Harris
//  @Date Apr 2021
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    private var defaults = UserDefaults.standard
    
    var itemArray = [Item]()
    
    // Data file path for NSCoder
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath!)
        
        let newItem1 = Item()
        newItem1.title = "Beets"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Bears"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Battlestar Galactica"
        itemArray.append(newItem3)
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
    }

    // Tableview datasource methods
    
    // Returns number of elements in list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.toToItemCellIdentifier, for: indexPath)
        let item = itemArray[indexPath.row]
        // label each item in the tableview
        cell.textLabel?.text = item.title
        // set checkmark
        cell.accessoryType = item.done ? .checkmark : .none
        //saveItems()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // debugging
        print(itemArray[indexPath.row])
        // set whether the item is done or not
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // recall DataSource methods for the table views
        tableView.reloadData()
        // grey-out item on touch
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new ToDoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { [weak self] (action) in
            print("Success!")
            //print(textField.text)
            let abpNewItem = Item()
            abpNewItem.title = textField.text!
            //self?.addItem(abpNewItem)
            self?.itemArray.append(abpNewItem)
            // save items to custom plist file
            self?.saveItems()
            // refresh table
            self?.tableView.reloadData()
        }
        // alert box to add new items
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        // add animation to add UI
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

private extension ToDoListViewController {
    
    func addItem(_ item: Item?) {
        guard let item = item else {
            return
        }
        itemArray.append(item)
        // persist the data using UserDefaults
        defaults.set(self.itemArray, forKey: "TodoListArray")
        tableView.reloadData()
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
                print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
}

private enum Constants {
    // String ID for item cells
    static let toToItemCellIdentifier = "ToDoItemCell"
    
}





