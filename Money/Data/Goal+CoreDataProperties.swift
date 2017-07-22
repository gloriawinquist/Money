//
//  Goal+CoreDataProperties.swift
//  Money
//
//  Created by Gloria Winquist on 7/16/17.
//  Copyright © 2017 glow. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var goalDate: NSDate?
    @NSManaged public var goalId: String?
    @NSManaged public var name: String?
    @NSManaged public var saved: Double
    @NSManaged public var total: Double

}
