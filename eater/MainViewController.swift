import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var mealTableView: UITableView!
    private let viewModel: DiceViewModel
    
    var meals = [Meal]()
    
    //MARK: Setup
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = DiceViewModel(meals: FindAllMeals().invoke())
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        mealTableView.delegate = self
        mealTableView.dataSource = self
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        meals = Array(FindAllMeals().invoke())
        mealTableView.reloadData()
    }
    
    //MARK: Actions
    @IBAction func tapDecide(_ sender: UIButton) {
        if viewModel.hasMeals() {
            performSegue(withIdentifier: "modalMealSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modalMealSegue" {
            if let destination = segue.destination as? ModalMealViewController {
                let randomMeal = viewModel.getRandomMeal()
                destination.newMealName = randomMeal!.name
                destination.newMealImage = randomMeal!.image
            }
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return meals.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]
        cell.mealName.text = meal.name
        cell.mealImage.image = meal.image
        
        return cell
    }
}


