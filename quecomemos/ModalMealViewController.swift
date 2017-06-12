//
//  ModalMealViewController.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 2/23/17.
//  Copyright © 2017 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class ModalMealViewController: UIViewController {

    
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    var newMealName : String?
    var newMealImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        mealName.text = newMealName
        mealImage.image = newMealImage
    }
    
    @IBAction func tapDone(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
