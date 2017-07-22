//
//  Transaction+CoreDataProperties.swift
//  Money
//
//  Created by Gloria Winquist on 7/16/17.
//  Copyright © 2017 glow. All rights reserved.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var transactionId: String?
    @NSManaged public var name: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var amount: Double
    @NSManaged public var budget: Budget?
    @NSManaged public var fromAccount: Account?
    @NSManaged public var toAccount: Account?

}
