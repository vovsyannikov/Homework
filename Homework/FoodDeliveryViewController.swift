//
//  FoodDeliveryViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 26.08.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

enum FoodType: String{
    case Burger = "Бургер"
    case Pizza = "Пицца"
    case Sushi = "Суши"
}

enum Star: String {
    case empty = "star"
    case halfFull = "star.lefthalf.fill"
    case full = "star.fill"
}

class Restaraunt{
    var restName = ""
    var rating = 0.0
    
    var stars: Dictionary<Star, UIImage> = [
        .empty   :UIImage(systemName: Star.empty.rawValue)!,
        .halfFull:UIImage(systemName: Star.halfFull.rawValue)!,
        .full:UIImage(systemName: Star.full.rawValue)!
    ]
    
    func getVisualRating() -> UIView{
        let ratingVisual = UIView.init()
        var starImageView: [UIImageView] = []
        let roundedRating = rating.rounded(FloatingPointRoundingRule.down)
        var remainderRating = rating - roundedRating
        var tempRating = rating
        
        for _ in 1...5{
            starImageView.append(UIImageView.init())
        }

        var index = 0
        while index < 5 {
            if tempRating - 1 > 0{
                starImageView[index].image = stars[.full]
                index += 1
                tempRating -= 1
            } else if tempRating - 1 == 0{
                starImageView[index].image = stars[.full]
                index += 1
                tempRating -= 1
            } else {
                if remainderRating >= 0.5 {
                    starImageView[index].image = stars[.halfFull]
                    index += 1
                    remainderRating = 0
                } else {
                    starImageView[index].image = stars[.empty]
                    index += 1
                    remainderRating = 0
                }
            }
        }
        
        var offset: CGFloat = 0
        let square: CGFloat = 15
        for star in starImageView{
            star.frame = CGRect(x: ratingVisual.bounds.minX + offset, y: ratingVisual.bounds.minY, width: square, height: square)
            offset += star.frame.size.width
            
            star.tintColor = UIColor(red: 0.9, green: 0.55, blue: 0, alpha: 1)
            ratingVisual.addSubview(star)
        }
        
        ratingVisual.frame = CGRect(x: 0, y: 0, width: square * CGFloat(starImageView.count), height: square)
        
        return ratingVisual
    }
}
class FoodItem: Restaraunt{
    var image = UIImage.init()
    var name = ""
    var description = ""
    var components: [String] = []
    var type = FoodType.init(rawValue: "")
    
    func getComponents() -> UIView {
        let resultView = UIView.init()
        var boxesImageViews: [UIImageView] = []
        var componentsLabels: [UILabel] = []
        
        let nameLabel = UILabel.init()
        nameLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 20)
        nameLabel.text = "Список ингредиентов: "
        nameLabel.font = UIFont.italicSystemFont(ofSize: 18)
        nameLabel.layer.borderWidth = 1
        
        resultView.addSubview(nameLabel)
        
        var offset: CGFloat = 0
        let boxSize: CGFloat = 20
        
        for (index, ingredient) in components.enumerated(){
            boxesImageViews.append(UIImageView.init())
            componentsLabels.append(UILabel.init())
            
            boxesImageViews[index].frame = CGRect(x: 0, y: nameLabel.frame.maxY + 10 + offset, width: boxSize, height: boxSize)
            componentsLabels[index].frame = CGRect(x: 5 + boxSize, y: nameLabel.frame.maxY + 10 + offset, width: 300, height: 20)
            
            offset += componentsLabels[index].frame.size.height
            
            boxesImageViews[index].image = UIImage(systemName: "square")?.withTintColor(UIColor.black)
            componentsLabels[index].text = ingredient
            
            resultView.addSubview(boxesImageViews[index])
            resultView.addSubview(componentsLabels[index])
        }
        
//        resultView.frame = CGRect(x: 0, y: 0, width: 0, height: (componentsLabels.last?.frame.maxY)! + 10)
        
        return resultView
    }
}

class FoodDeliveryViewController: UIViewController {
    
    @IBOutlet weak var foodScrollView: UIScrollView!
    
    var food: [FoodItem] = []
    
    func addToView(_ item: FoodItem) -> UIView{
        let cell = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let photo = UIImageView.init()
        photo.frame = CGRect(x: cell.bounds.minX + 10, y: cell.bounds.minX + 10, width: 150, height: 150)
        photo.image = item.image
        
        cell.frame.size.height += photo.frame.size.height
        
        
        let nameLabel = UILabel.init()
        nameLabel.frame = CGRect(x: photo.bounds.maxX + 25, y: cell.bounds.minY + 10, width: cell.bounds.maxX - photo.frame.width - 30, height: 50)
        nameLabel.text = item.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.numberOfLines = 0
        
        
        let restNameLabel = UILabel.init()
        restNameLabel.frame = CGRect(x: nameLabel.frame.minX, y: nameLabel.frame.maxY, width: nameLabel.frame.size.width, height: nameLabel.frame.size.height / 2)
        restNameLabel.text = item.restName
        restNameLabel.font = UIFont.italicSystemFont(ofSize: 14)
        restNameLabel.textColor = UIColor.lightGray
        restNameLabel.numberOfLines = 0
        
        
        let ratingView = item.getVisualRating()
        ratingView.frame = CGRect(x: restNameLabel.frame.minX, y: restNameLabel.frame.maxY, width: ratingView.frame.size.width, height: ratingView.frame.size.height)
        
        
        let foodTypeLabel = UILabel.init()
        foodTypeLabel.frame = CGRect(x: ratingView.frame.minX, y: ratingView.frame.maxY + 10, width: nameLabel.frame.size.width, height: 20)
        foodTypeLabel.text = item.type?.rawValue
        
        let descriptionView = UIView.init()
        let descriptionTitle = UILabel.init()
        
        descriptionTitle.frame = CGRect(x: 0, y: 0, width: 150, height: 20)
        descriptionTitle.text = "Описание: "
        descriptionTitle.font = UIFont.italicSystemFont(ofSize: 18)
        
        
        let descriptionLabel = UILabel.init()
        descriptionLabel.frame = CGRect(x: 0, y: descriptionTitle.frame.maxY, width: cell.bounds.width - 15, height: 150)
        descriptionLabel.text = item.description
        descriptionLabel.numberOfLines = 0
        
        
        descriptionView.frame = CGRect(x: photo.frame.minX, y: photo.frame.maxY + 10, width: cell.bounds.width, height: descriptionLabel.frame.height + 20)
        descriptionView.addSubview(descriptionTitle)
        descriptionView.addSubview(descriptionLabel)
        
        cell.frame.size.height += descriptionView.frame.height
        
        
        let componentsView = item.getComponents()
        componentsView.frame = CGRect(x: photo.frame.minX, y: descriptionView.frame.maxY + 10, width: cell.bounds.width - 15, height: (componentsView.subviews.last?.frame.maxY)!)
        componentsView.layer.borderWidth = 1
        
        cell.frame.size.height += componentsView.frame.height
        
        let lineLabel = UILabel.init()
        lineLabel.frame = CGRect(x: cell.frame.minX, y: cell.frame.height, width: cell.frame.size.width, height: 1)
        lineLabel.layer.borderWidth = 0.25
        lineLabel.layer.borderColor = UIColor.red.cgColor
        
        cell.frame.size.height += lineLabel.frame.size.height
        
        
        cell.addSubview(photo)
        cell.addSubview(nameLabel)
        cell.addSubview(restNameLabel)
        cell.addSubview(ratingView)
        cell.addSubview(foodTypeLabel)
        cell.addSubview(descriptionView)
        cell.addSubview(componentsView)
        cell.addSubview(lineLabel)
        
        return cell
    }
    
    func makeSomeFood(){
        
        for _ in 1...2 {
            food.append(FoodItem())
        }
        
        food[0].restName = "Texas burgers"
        food[0].rating = 4.75
        
        // TODO: Remake image
        food[0].image = UIImage(systemName: Star.full.rawValue)!
        
        food[0].name = "Техасский оригинальный бургер"
        food[0].description = "Рецепт этого сочного бургера  привезен прямиком из южных широт США. Пропитанный запахом свободы и открытого огня. В сочетании с нашим фирменным соусом \"Техас\" этот бургер превращается в произведение искусства, которое вы не можете пропустить!"
        food[0].components.append(contentsOf: [
            "Говядина",
            "Соленые огурчики",
            "Сыр Чеддар",
            "Помидор",
            "Салат",
            "Фирменный соус \"Техас\""
        ])
        food[0].type = .Burger
        
        
        
        food[1].restName = "У Джорджины"
        food[1].rating = 4.0
        
        food[1].image = UIImage(systemName: "circle.fill")!
        
        food[1].name = "Маргарита"
        food[1].description = "Классическая пицца без лишних наполнителей. Нежное тесто, приготовленное вручную, сыр моцарелла и пикантный томатный соус по оригинальному рецепту перенесет вас из любой точки мира в солнечную Италию."
        food[1].components.append(contentsOf: [
            "Сыр моцарелла",
            "Томатный соус"
        ])
        food[1].type = .Pizza
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSomeFood()
        
        var cells: [UIView] = []
        var h: CGFloat = 0
        
        for item in food{
            cells.append(addToView(item))
        }
            
        for cell in cells {
            cell.frame = CGRect(x: 0, y: h, width: cell.frame.size.width, height: cell.frame.size.height)
            h += cell.frame.height
            
            foodScrollView.addSubview(cell)
        }
        
        foodScrollView.contentSize = CGSize(width: view.frame.size.width, height: h + 15)
    }

}
