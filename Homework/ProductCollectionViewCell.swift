//
//  ProductCollectionViewCell.swift
//  Homework
//
//  Created by Виталий Овсянников on 24.08.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var prevPriceLabel: UILabel!
    @IBOutlet weak var currPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
}
