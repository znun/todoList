//
//  ViewController.swift
//  UserDefaults
//
//  Created by Mahmudul Hasan on 17/6/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var myTable: UITableView!
    
    var todoArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.object(forKey: "todoList") as? [String] {
            todoArray = data
            statusLbl.text = "\(todoArray.count) task pending on todo list"
        } else {
            statusLbl.text = "No task Pending"
        }
       
    }

   
    @IBAction func saveBtn(_ sender: Any) {
        
        if textField.text != "" {
            todoArray.append(textField.text!)
            UserDefaults.standard.set(todoArray, forKey: "todoList")
            myTable.reloadData()
            statusLbl.text = "New status added on todo list"
            textField.text = ""
        } else {
            statusLbl.text = "Kindly enter status first"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        todoArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
        myTable.reloadData()
    }
    
}

