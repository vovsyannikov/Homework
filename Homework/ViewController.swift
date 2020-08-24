//
//  ViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 23.08.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var products: [(name: String, currentPrice: String, prevPrice: String, image: UIImage)] = []
    let productImageNames: [(name: String, price: Int)] = [
        (name: "BrakeDisc",         price: 15_000),
        (name: "BrakePads",         price: 5_000),
        (name: "LeftHeadlamp",      price: 45_000),
        (name: "RightHeadlamp",     price: 45_000),
        (name: "PhoneHolder",       price: 1_500),
        (name: "RearviewMirror",    price: 4_000),
        (name: "Windshield",        price: 10_000)
    ]
    
    func getProducts(){
        
        // Форматирование имени из camelWord в слова с пробелами ("BrakeDisc" -> "Brake disc")
        func formatName(_ camelName: String) -> String {
            var newName = ""
            
            for (i, c) in camelName.enumerated(){
                if c.isUppercase && i != 0 {
                    newName += " \(c.lowercased())"
                } else {
                    newName += "\(c)"
                }
            }
            
            return newName
            
        }
        
        // Форматирование цены из числа в строку (15000 -> "15 000 ₽")
        func formatPrice(_ dblPrice: Int) -> String{
            var newPrice = ""
            let priceString = String(dblPrice)
            
            var thousand = 0
            for c in priceString.reversed(){
                if thousand == 3{
                    newPrice += " \(c)"
                    thousand = 0
                } else {
                    newPrice += "\(c)"
                    thousand += 1
                }
            }
            
            newPrice = String(newPrice.reversed()) + " ₽"
            
            return newPrice
        }
       
        // Функция проверки заполнения массива продуктов
        /*
        func checkProducts(){
            for p in products{
                print("\(p.name) is currently worth \(p.currentPrice) with old price being \(p.prevPrice) and it looks like this \(p.image)")
            }
        }*/
        
        // Различные размеры скидок на товары
        let sales = [1.0, 1.05, 1.1, 1.15, 1.33, 1.5, 1.75]
        
        for p in productImageNames{
            // Создание старой цены с использованием одной из скидок
            let dblPrice = Double(p.price) * sales.randomElement()!

            // Округление скидки
            let prevPrice = Int(dblPrice.rounded())
            
            // Добавление продукта
            products.append((
                name: formatName(p.name),
                currentPrice: formatPrice(p.price),
                prevPrice: formatPrice(prevPrice),
                image: UIImage.init(named: p.name)!
            ))
        }
        
//        checkProducts()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getProducts()
    }


}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        
        return cell
    }
}
