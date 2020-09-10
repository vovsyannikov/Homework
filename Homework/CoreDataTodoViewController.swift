//
//  CoreDataTodoViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 10.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit
import CoreData


class CoreDataTodoViewController: UIViewController {
    
    @IBOutlet weak var todoTableView: UITableView!
    private var todos: [String] = []
    
    func createData(for todo: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let todoEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        let task = NSManagedObject(entity: todoEntity, insertInto: managedContext)
        task.setValue(todo, forKey: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error \(error)")
        }
    }
    func retrieveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                todos.append(data.value(forKey: "name") as! String)
//                print(data.value(forKey: "name") as! String)
                print(todos)
            }
        } catch let error {
            print(error)
        }
    }
    // MARK: Не работает удаление
    func deleteData(withTag del: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "name = %@", del)
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            for (index, ent) in test.enumerated() {
                print(index, ent)
            }
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
            } catch let error {
                print(error)
            }
            
        } catch let error {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        todoTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddTodoViewController, segue.identifier == "AddTodoCore" {
            vc.delegate = self
        }
    }

}

extension CoreDataTodoViewController: AddTodoDelegate{
    func addTodo(_ text: String) {
        todos.append(text)
        print(todos)
        createData(for: text)
        todoTableView.reloadData()
    }
}

extension CoreDataTodoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todo") as! TodoListTableViewCell
        
        cell.positionLabel.text = "\(indexPath.row + 1)"
        cell.todoLabel.text = todos[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            
            
            deleteData(withTag: todos[indexPath.row])
            self.todoTableView.beginUpdates()
            self.todoTableView.reloadSections(IndexSet(indexPath), with: .automatic)
            self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
            self.todoTableView.endUpdates()
            
        }
    }
    
}
