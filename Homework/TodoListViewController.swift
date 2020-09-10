//
//  TodoListViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 10.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit
import RealmSwift

class Todos: Object{
    @objc dynamic var name = ""
}

class TodoListViewController: UIViewController {
    
    private let realm = try! Realm()

    @IBOutlet weak var todoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddTodoViewController, segue.identifier == "AddTodo" {
            vc.delegate = self
        }
    }
    
}

extension TodoListViewController: AddTodoDelegate{
    func addTodo(_ text: String) {
        let todo = Todos()
        todo.name = text
        
        try! realm.write{
            realm.add(todo)
        }
        
        todoTableView.reloadData()
    }
    
}

extension TodoListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Todos.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todo") as! TodoListTableViewCell
        
        let todos = realm.objects(Todos.self)
        
        cell.positionLabel.text = "\(indexPath.row + 1)"
        cell.todoLabel.text = todos[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            
            var objectToDelete = Todos()
            for (index, obj) in realm.objects(Todos.self).enumerated(){
                if index == indexPath.row{
                    objectToDelete = obj
                }
            }
            
            try! realm.write{
                realm.delete(objectToDelete)
            }
            self.todoTableView.beginUpdates()
            self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
            self.todoTableView.endUpdates()
            
            self.todoTableView.reloadData()
        }
    }
}
