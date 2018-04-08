import Foundation
import UIKit

class MealModel: NSObject, NSCoding {
    
    //MARK: Properties
    let uuid: String
    let name: String
    let image: UIImage
    
    static func from(meal: Meal) -> MealModel {
        return MealModel(uuid: meal.uuid, name: meal.name, image: meal.image!)
    }
    
    private init(uuid: String, name: String, image: UIImage) {
        self.uuid = uuid
        self.name = name
        self.image = image
        super.init()
    }
    
    //MARK: NSCoding
    struct PropertyKey {
        static let uuidKey = "u"
        static let nameKey = "n"
        static let photoKey = "p"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uuid, forKey: PropertyKey.uuidKey)
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(image, forKey: PropertyKey.photoKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let uuid = aDecoder.decodeObject(forKey: PropertyKey.uuidKey) as! String
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let image = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as! UIImage
        
        self.init(uuid: uuid, name: name, image: image)
    }
    
}
