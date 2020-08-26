//
//  FoodDeliveryViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 26.08.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class Restaraunt{
    var restName = ""
    var rating = 0.0
    
    func setRest(restName: String, rating: Double){
        self.restName = restName
        self.rating = rating
    }
}

class FoodItem: Restaraunt{
    var image = UIImage.init()
    var name = ""
    var description = ""
    var components: [(checkbox: UIImage, ingr: String)] = []
    
    func makeFood(restName: String, restRating: Double, image: UIImage, name: String, description: String, components: [(checkbox: UIImage, ingr: String)]) {
        
        setRest(restName: restName, rating: restRating)
        self.image = image
        self.name = name
        self.description = description
        self.components = components
    }
}

class FoodDeliveryViewController: UIViewController {
    
    @IBOutlet weak var foodScrollView: UIScrollView!
    
    var food = [FoodItem()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}
