//
//  FoodDeliveryViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 26.08.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

enum FoodType{
    case Burger
    case Pizza
    case Sushi
}

enum Star: String {
    case empty = "star"
    case halfFull = "star.lefthalf.fill"
    case full = "star.fill"
}

class Restaraunt{
    var restName = ""
    var rating = 0.0
    let stars: Dictionary<Star, UIImage> = [
        .empty   :UIImage(systemName: Star.empty.rawValue)!,
        .halfFull:UIImage(systemName: Star.halfFull.rawValue)!,
        .full:UIImage(systemName: Star.full.rawValue)!
    ]
    
//    func getVisualRating() -> UIView{
//        var ratingVisual = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 80))
//        var tempRating = rating
//
//        for _ in 1...5{
//            if tempRating.rounded() > 0{
//                tempRating -= 1
//                ratingVisual.addSubview(UIImageView(image: stars[.full]))
//            } else if tempRating > 0{
//
//            }
//        }
//
//        return ratingVisual
//    }
}
class FoodItem: Restaraunt{
    var image = UIImage.init()
    var name = ""
    var description = ""
    var components: [String] = []
    var type = FoodType.Burger
}

class FoodDeliveryViewController: UIViewController {
    
    @IBOutlet weak var foodScrollView: UIScrollView!
    
    var food = [FoodItem()]
    
    func makeSomeFood(){
        
        for _ in 1...3 {
            food.append(FoodItem())
        }
        
        food[0].restName = "Texas burgers"
        food[0].rating = 4.5
        
        food[0].name = "Техасский оригинальный бургер"
        food[0].description = "Рецепт этого сочного бургера  привезен прямиком из южных широт США. Пропитанный запахом свободы и открытого огня. В сочетании с нашим фирменным соусом \"Техас\" этот бургер превращается в часть искусства, которое вы не можете пропустить!"
        food[0].components.append(contentsOf: ["Говядина", "Соленые огурчики", "Сыр Чеддар", "Помидор", "Салат", "Булочки", "Фирменный соус \"Техас\""])
        
        let cell = UIView(frame: CGRect(x: 0, y: 25, width: view.frame.size.width, height: 100))
        var nameLabel = UILabel.init()
        nameLabel.text = food[0].name
        nameLabel.frame = CGRect(x: cell.bounds.minX + 5, y: cell.bounds.minY + 5, width: 150, height: 80)
        cell.addSubview(nameLabel)
        foodScrollView.addSubview(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSomeFood()
        foodScrollView.contentSize = CGSize(width: view.frame.size.width, height: CGFloat(food.count * 100))
    }

}
