//
//  Meal.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 10/18/16.
//  Copyright © 2016 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class Meal: NSObject {
    
    //MARK: Properties
    let uuid: String
    let name: String
    let place: String
    let notes: String
    var image: UIImage?
    
    static func create(withName name: String, withPlace place: String, withNotes notes: String, withImage image: UIImage?) -> Meal {
        return Meal(uuid: NSUUID().uuidString, name: name, place: place, notes: notes, image: image)!
    }
    
    init?(uuid: String, name: String, place: String, notes: String, image: UIImage?) {
        //Validation
        guard !name.isEmpty else { return nil }
        
        self.uuid = uuid
        self.name = name
        self.place = place
        self.notes = notes
        self.image = image
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let meal = object as? Meal {
            return uuid == meal.uuid
        } else {
            return false
        }
    }
    
    override var hashValue: Int {
        return uuid.hashValue
    }
}
