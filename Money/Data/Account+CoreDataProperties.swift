//
//  Account+CoreDataProperties.swift
//  Money
//
//  Created by Gloria Winquist on 7/16/17.
//  Copyright © 2017 glow. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var balance: Double
    @NSManaged public var name: String?
    @NSManaged public var accountId: String?
    @NSManaged public var debits: NSSet?
    @NSManaged public var credits: NSSet?

}

// MARK: Generated accessors for debits
extension Account {

    @objc(addDebitsObject:)
    @NSManaged public func addToDebits(_ value: Transaction)

    @objc(removeDebitsObject:)
    @NSManaged public func removeFromDebits(_ value: Transaction)

    @objc(addDebits:)
    @NSManaged public func addToDebits(_ values: NSSet)

    @objc(removeDebits:)
    @NSManaged public func removeFromDebits(_ values: NSSet)

}

// MARK: Generated accessors for credits
extension Account {

    @objc(addCreditsObject:)
    @NSManaged public func addToCredits(_ value: Transaction)

    @objc(removeCreditsObject:)
    @NSManaged public func removeFromCredits(_ value: Transaction)

    @objc(addCredits:)
    @NSManaged public func addToCredits(_ values: NSSet)

    @objc(removeCredits:)
    @NSManaged public func removeFromCredits(_ values: NSSet)

}
