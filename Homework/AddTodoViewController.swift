//
//  AddTodoViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 10.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

protocol AddTodoDelegate {
    func addTodo(_ text: String)
}

class AddTodoViewController: UIViewController {

    @IBOutlet weak var todoTextField: UITextField!
    var delegate: AddTodoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func todoReturn(_ sender: Any) {
        delegate?.addTodo(todoTextField.text!)
        dismiss(animated: true, completion: nil)
    }

}
