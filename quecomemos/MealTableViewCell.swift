//
//  MealTableViewCell.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 10/24/16.
//  Copyright © 2016 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var mealName: UILabel! {
        willSet {
            newValue.text = newValue.text?.capitalized
        }
    }
    @IBOutlet weak var mealImage: UIImageView!

}
