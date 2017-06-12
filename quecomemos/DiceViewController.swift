//
//  DiceViewController.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 11/20/16.
//  Copyright © 2016 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class DiceViewController: UIViewController, UINavigationControllerDelegate{

    @IBOutlet weak var diceImage: UIImageView!
    var meals = [Meal]()
    var randomMeal : Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cleanNavBar()
        
        if meals.isEmpty && nil == loadMeals() {
            print("Initializating meals")
            loadSampleMeals()
            saveMeals()
        }
    }
    
    func cleanNavBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    @IBAction func throwDices(_ sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.diceImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: nil )
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.diceImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        }) { isFinished in self.showRandomMeal() }
        
    }
    
    func showRandomMeal() {
        if let meals = loadMeals() {
            let randomIndex = Int.getRandom(max: meals.count)
            randomMeal = meals[randomIndex]
            performSegue(withIdentifier: "modalMealSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modalMealSegue" && randomMeal != nil {
            if let destination = segue.destination as? ModalMealViewController {
                destination.newMealName = randomMeal!.name
                destination.newMealImage = randomMeal!.image
            }
        }
    }
    
    func loadSampleMeals(){
        let mealExample = Meal(name: "Milanesa", image: UIImage(named: "milanesa"))!
        let mealExample2 = Meal(name: "Hamburguesa", image: UIImage(named: "hamburguesa"))!
        
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

extension Int {
    static func getRandom(max : Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
}
