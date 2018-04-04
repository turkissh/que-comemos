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
    @IBOutlet weak var confirmationButton: UIButton!
    
    var newMealName : String?
    var newMealImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfirmButton()
        
        mealName.text = newMealName
        mealImage.image = newMealImage
    }
    
    private func setConfirmButton() {
        confirmationButton.layer.cornerRadius = 20
        confirmationButton.layer.borderWidth = 1
        confirmationButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func tapDone(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
