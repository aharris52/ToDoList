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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "Beets"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Bears"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Battlestar Galactica"
        itemArray.append(newItem3)
    }

    // Tableview datasource methods
    
    // Returns number of elements in list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.toToItemCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //debugging
        print(itemArray[indexPath.row])
        // add/remove checkmarks from list
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
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
            self?.addItem(abpNewItem)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
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
    
}

private enum Constants {
    static let toToItemCellIdentifier = "ToDoItemCell"
}





