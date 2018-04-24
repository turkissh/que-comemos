import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var mealTableView: UITableView!
    private var viewModel: DiceViewModel
    private var shouldLoadMeals: Bool = false
    private var repositoryMeals: Set<Meal>
    fileprivate var meals = [Meal]()
    
    //MARK: Setup
    required init?(coder aDecoder: NSCoder) {
        repositoryMeals = FindAllMeals().invoke()
        meals = Array(repositoryMeals)
        self.viewModel = DiceViewModel(meals: repositoryMeals)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTableView.delegate = self
        mealTableView.dataSource = self
        mealTableView.bounces = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shouldLoadMeals = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldLoadMeals {
            self.repositoryMeals = FindAllMeals().invoke()
            meals = Array(repositoryMeals)
            self.viewModel.updateMeals(meals: repositoryMeals)
            mealTableView.reloadData()
            mealTableView.setContentOffset(CGPoint.zero, animated: true)
            shouldLoadMeals = false
        }
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


