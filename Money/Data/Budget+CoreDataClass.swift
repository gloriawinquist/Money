//
//  Budget+CoreDataClass.swift
//  Money
//
//  Created by Gloria Winquist on 7/16/17.
//  Copyright © 2017 glow. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Budget)

/// The Budget class is used to represent budget items. A budget item has a type, yearlyAllowance, and a usedUp amount. The usedUp amount is the amount that has been spent on that budget item during this calendar year.  
final public class Budget: NSManagedObject {
    
    convenience init(budgetType: String, yearlyAllowance: Double, usedUp: Double, context: NSManagedObjectContext) {
        
        self.init(context: context)
        self.budgetId = UUID().uuidString
        self.budgetType = budgetType
        self.yearlyAllowance = yearlyAllowance
        self.usedUp = usedUp
    }
    
    // MARK: - Computed Properties
    
    var annualRemaining: Double {
        return yearlyAllowance - usedUp
    }
    
    var annualSpentRatio: Double {
        
        if usedUp < 0.0 || yearlyAllowance <= 0.0 {
            return 0.0
        }
        return usedUp / yearlyAllowance
    }
    
    var monthlyAllowance: Double {
        return yearlyAllowance / 12.0
    }
    
    var monthlyRemaining: Double {
        return monthlyAllowance - monthlySpent
    }
    
    var monthlySpent: Double {
        
        // subtract number of months * monthly allowance from usedUp with January = 0
        let month = Calendar.current.component(.month, from: Date()) - 1
        return usedUp - (monthlyAllowance * Double(month))
    }
    
    var monthlySpentRatio: Double {
        
        if monthlySpent < 0.0 || monthlyAllowance <= 0.0 {
            return 0.0
        }
        return monthlySpent / monthlyAllowance
    }
    
}
