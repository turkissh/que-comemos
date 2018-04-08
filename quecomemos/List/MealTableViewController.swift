import UIKit

class MealTableViewCell: UITableViewCell {
    @IBOutlet weak var mealName: UILabel! {
        willSet {
            newValue.text = newValue.text?.capitalized
        }
    }
    @IBOutlet weak var mealImage: UIImageView!
}

class MealTableViewController: UITableViewController {

    private let deleteMeal = DeleteMeal()
    fileprivate let createMeal = CreateMeal()
    fileprivate let updateMeal = UpdateMeal()
    
    var meals = [Meal]()
    var editingButton: UIBarButtonItem!
    var addButton: UIBarButtonItem!
    var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        initButtons()
        meals = Array(FindAllMeals().invoke())
        super.viewDidLoad()
    }
    
    private func initButtons() {
        backButton = self.navigationItem.leftBarButtonItem
        editingButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(showEditing))
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(callAddMeal))
        self.navigationItem.rightBarButtonItem = editingButton
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

        cell.mealName.text = meal.name.capitalized
        cell.mealImage.image = meal.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let mealToRemove = meals[indexPath.row]
            
            deleteMeal.invoke(mealToRemove)
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mealDetailViewController = segue.destination as? MealViewController {
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
            mealDetailViewController.delegate = self
        }
    }
    
    func showEditing(sender: UIBarButtonItem){
        if (self.tableView.isEditing == true) {
            self.tableView.isEditing = false
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.navigationItem.leftBarButtonItem = backButton
        } else {
            self.tableView.isEditing = true
            self.navigationItem.rightBarButtonItem?.title = "Done"
            self.navigationItem.leftBarButtonItem = addButton
        }
    }
    
    func callAddMeal(){
        performSegue(withIdentifier: "Add Meal", sender: self)
    }
    
}

extension MealTableViewController : MealTableViewControllerDelegate {
    
    func updateMeal(meal: Meal) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            update(existingMeal: meal, inIndex: selectedIndexPath)
        } else {
            create(meal: meal)
        }
        
    }
    
    private func update(existingMeal meal: Meal, inIndex selectedIndex: IndexPath) {
        let exitingMeal = meals[selectedIndex.row]
        meals[selectedIndex.row] = meal
        tableView.reloadRows(at: [selectedIndex], with: .none)
        updateMeal.invoke(existingMeal: exitingMeal, newMeal: meal)
    }
    
    private func create(meal: Meal) {
        let newIndexPath = IndexPath(item: meals.count, section: 0)
        meals.append(meal)
        tableView.insertRows(at: [newIndexPath], with: .bottom)
        
        createMeal.invoke(meal)
    }
}
