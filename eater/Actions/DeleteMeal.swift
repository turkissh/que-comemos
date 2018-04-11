import Foundation

class DeleteMeal: BaseAction {
    
    func invoke(_ meal: Meal) {
        repository.remove(meal: meal)
    }
    
}
