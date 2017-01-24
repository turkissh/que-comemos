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
        print("throwing dices")
        UIView.animate(withDuration: 1) {
            self.diceImage.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        }
        
        UIView.animate(withDuration: 1, delay: 0.40, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.diceImage.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI * 2))
        }) { isFinished in self.showRandomMeal() }
        
    }
    
    func showRandomMeal() {
        var meals = loadMeals()
        if (meals != nil) {
            print("meals: " +  String(meals!.count))
            let randomIndex = Int.getRandom(max: meals!.count)
            let randomMeal = meals![randomIndex]
            
            //Create alert
            let alert = UIAlertController(title: "Puedes comer:", message: "\(randomMeal.name.capitalized)", preferredStyle: .alert)
            let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.50)
            alert.view.addConstraint(height)
            //Set alert button
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            //Set alert image
            let imageView = UIImageView(frame: CGRect(x: self.view.frame.width / 8, y: 130, width: self.view.frame.width / 2, height: self.view.frame.width / 2))
            imageView.image = randomMeal.image
            alert.view.addSubview(imageView)
            
            //Show alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func loadSampleMeals(){
        let mealExample = Meal(name: "milanesa", image: UIImage(named: "milanesa"))!
        let mealExample2 = Meal(name: "hamburguesa", image: UIImage(named: "hamburguesa"))!
        
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
