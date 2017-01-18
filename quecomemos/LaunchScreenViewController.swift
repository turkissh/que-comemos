//
//  LaunchScreenViewController.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 1/6/17.
//  Copyright © 2017 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Initializating meals")
        if loadMeals() == nil {
            loadSampleMeals()
            saveMeals()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSampleMeals(){
        let mealExample = Meal(name: "milanesa", rating: 4, image: UIImage(named: "milanesa"))!
        let mealExample2 = Meal(name: "hamburguesa", rating: 5, image: UIImage(named: "hamburguesa"))!
        
        meals += [mealExample,mealExample2]
    }
    
    func saveMeals(){
        let isSuccesfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL!.path)
        
        print("Meal saved: " + isSuccesfulSave.description)
    }
    
    func loadMeals() -> [Meal]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL!.path) as? [Meal]
    }
   

}
