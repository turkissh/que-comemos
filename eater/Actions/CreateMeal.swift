import Foundation

class CreateMeal: BaseAction {
    
    func invoke(_ meal: Meal) {
        repository.save(meal: meal)
    }
    
}
