//
//  MealTableViewController.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 10/24/16.
//  Copyright © 2016 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    //MARK: Properties
    var meals = [Meal]()
    var editingButton: UIBarButtonItem!
    var addButton: UIBarButtonItem!
    var backButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButtons()
        
        self.navigationItem.rightBarButtonItem = editingButton
        
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        
    }
    
    
    
    func initButtons(){
        backButton = self.navigationItem.leftBarButtonItem
        editingButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(showEditing))
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(callAddMeal))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]

        cell.mealName.text = meal.name
        cell.mealImage.image = meal.image
        cell.mealRating.rating = meal.rating
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            //Saves updated meals
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            //Checks if there was a row selected
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                //Updates existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                
                //Add a new meal
                let newIndexPath = IndexPath(item: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
                
            }
            
            //Saves meals
            saveMeals()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Detail" ,
           let mealDetailViewController = segue.destination as? MealViewController {
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
        } else if segue.identifier == "Add Meal" {
            print("Adding new meal.")
        }
    }
    
    func showEditing(sender: UIBarButtonItem){
        if(self.tableView.isEditing == true)
        {
            self.tableView.isEditing = false
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.navigationItem.leftBarButtonItem = backButton
        }
        else
        {
            self.tableView.isEditing = true
            self.navigationItem.rightBarButtonItem?.title = "Done"
            self.navigationItem.leftBarButtonItem = addButton
        }
    }
    
    func callAddMeal(){
        performSegue(withIdentifier: "Add Meal", sender: self)
    }
    
    //MARK: NSCoding
    
    func saveMeals(){
        let isSuccesfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL!.path)
        
        print("Meal saved: " + isSuccesfulSave.description)
    }
    
    func loadMeals() -> [Meal]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL!.path) as? [Meal]
    }

}
