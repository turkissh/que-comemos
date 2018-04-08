import Foundation

class DiceViewModel {
    
    private let meals: Set<Meal>
    
    init(meals: Set<Meal>) {
        self.meals = meals
    }
    
    func hasMeals() -> Bool {
        return !meals.isEmpty
    }
    
    func getRandomMeal() -> Meal? {
        return meals.randomElement()
    }
    
}

fileprivate extension Set {
    fileprivate func randomElement() -> Element? {
        let n = Int(arc4random_uniform(UInt32(self.count)))
        let index = self.index(self.startIndex, offsetBy: n)
        return self.count > 0 ? self[index] : nil
    }
}
