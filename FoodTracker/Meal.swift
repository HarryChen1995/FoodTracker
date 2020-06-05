//
//  Meal.swift
//  FoodTracker
//
//  Created by Hanlin Chen on 5/26/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import UIKit
import os.log
class Meal : NSObject, NSCoding{
    // MARK:Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // MARK: Types
    struct propertyKey{
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    // MARK: Initialization
    init?(name:String, photo: UIImage?, rating:Int){

        guard !name.isEmpty else {
            return nil
        }
        guard (rating >= 0) && (rating <= 5)else{
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    // MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: propertyKey.name)
        coder.encode(photo, forKey: propertyKey.photo)
        coder.encode(rating, forKey: propertyKey.rating)
        
    }
    
    required convenience init?(coder: NSCoder) {
        // the name is required if we cannot decode a name string, the initializer should be fail
        guard let name = coder.decodeObject(forKey: propertyKey.name) as? String else {
            os_log("unable to decode the name for a meal object", log:OSLog.default, type: .debug)
            return nil
        }
        // Becasue photo is optinal property of Meal , just use conditional cast
        
        let photo = coder.decodeObject(forKey: propertyKey.photo) as? UIImage
        
        let rating = coder.decodeInteger(forKey: propertyKey.rating)
        // Must call designated initializer
        self.init(name:name, photo:photo, rating:rating)
    }
}
