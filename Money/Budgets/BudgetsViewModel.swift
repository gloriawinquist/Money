//
//  BudgetsViewModel.swift
//  Money
//
//  Created by Gloria Winquist on 7/15/17.
//  Copyright © 2017 glow. All rights reserved.
//

import Foundation
import CoreData

// The view model for the BudgetsViewController and its children. Manages the budgets that are added and displayed in the app.
final class BudgetsViewModel {
    
    /// The various budget categories that are available
    enum BudgetType: String {
        
        case birthdayPresents = "Birthday Presents"
        case cable = "Cable"
        case charity = "Charity"
        case clothing = "Clothing"
        case commuting = "Commuting"
        case eatingOut = "Eating Out"
        case electricity = "Electricity"
        case entertainment = "Entertainment"
        case extracurriculars = "Extracurriculars"
        case fees = "Fees"
        case fuel = "Fuel"
        case gifts = "Gifts"
        case groceries = "Groceries"
        case health = "Health"
        case heat = "Heat"
        case hobbies = "Hobbies"
        case holidays = "Holidays"
        case houseSupplies = "House Supplies"
        case insurance = "Insurance"
        case kids = "Kids"
        case medical = "Medical Expenses"
        case miscellaneous = "Miscellaneous"
        case phone = "Phone"
        case propertyTax = "Property Tax"
        case rent = "Rent"
        case school = "School"
        case vacation = "Vacation"
        case water = "Water"
        
        static let all: [BudgetType] = [.birthdayPresents, .cable, .charity, .clothing, .commuting, .eatingOut, .electricity, .entertainment, .extracurriculars, .fees, .fuel, .gifts, .groceries, .health, .heat, .hobbies, .holidays, .houseSupplies, .insurance, .kids, .medical, .miscellaneous, .phone, .propertyTax,
                                        .rent, .school, .vacation, .water]
    }
    
    // Cell types used by the BudgetInputViewController
    enum BudgetInputCellType: Int {
        
        case budgetType
        case yearlyAllowance
        case monthlyAllowance
        case usedUp
        
        var displayLabel: String {
            
            switch self {
            case .budgetType:
                return "Budget Type"
            case .yearlyAllowance:
                return "Annual Allowance"
            case .monthlyAllowance:
                return "Monthly Allowance"
            case .usedUp:
                return "Spent So Far"
            }
        }
        
    }
    
    // A struct that contains the relevant fields to summarize the budget is passed into the BudgetSummaryTableViewCell
    struct BudgetSummary {
        
        let netAnnualIncome: Double
        let annualBudget: Double
        let annualRemaining: Double
        let monthlyRemaining: Double
        
        var netMonthlyIncome: Double {
            return netAnnualIncome / 12.0
        }
        
        var monthlyBudget: Double {
            return annualBudget / 12.0
        }
        
        var annualSaved: Double {
            return netAnnualIncome - annualBudget
        }
        
        var monthlySaved: Double {
            return netMonthlyIncome - monthlyBudget
        }
    }
    
    // HARDCODED
    let netAnnualIncome = 81000.00
    
    // BudgetsViewController
    var budgets = [Budget]()
    
    // BudgetInputViewController
    var newInputAnnualBudgetAmount = 0.0
    var newInputAnnualSpentAmount = 0.0
    
    // BudgetTypesTableViewController
    let budgetTypes = BudgetType.all
    var selectedBudgetType: BudgetType?
    
    // MARK: - Public Methods
    
    // fetches all of the Budget items out of core data
    func fetchBudgetItems() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = Budget.fetchRequest() as NSFetchRequest<Budget>
        do {
            budgets = try context.fetch(fetchRequest)
        }
        catch let error {
            print("Failed to fetch because of error: \(error).")
        }
    }
    
    // creates and saves a Budget object using inputs entered in the BudgetInputViewController
    @discardableResult func createBudgetItem() -> Budget? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let theBudgetType = selectedBudgetType else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let newBudgetItem = Budget(budgetType: theBudgetType.rawValue, yearlyAllowance: newInputAnnualBudgetAmount, usedUp: newInputAnnualSpentAmount, context: context)
        resetNewBudgetAttributes()
        
        do {
            try context.save()
        }
        catch let error {
            print("Could not save because of \(error).")
        }
        return newBudgetItem
    }
    
    // creates a BudgetSummary object to be passed into the BudgetSummaryTableViewCell
    func createBudgetSummary() -> BudgetSummary {
        
        let budgeted = budgets.reduce(0.0, { $0 + $1.yearlyAllowance })
        let annualRemaining = budgets.reduce(0.0, { $0 + $1.annualRemaining })
        let monthlyRemaining = budgets.reduce(0.0, { $0 + $1.monthlyRemaining })
        
        return BudgetSummary(netAnnualIncome: netAnnualIncome, annualBudget: budgeted, annualRemaining: annualRemaining, monthlyRemaining: monthlyRemaining)
    }
    
    func delete(budget: Budget, at indexPath: IndexPath) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        context.delete(budget)
        budgets.remove(at: indexPath.row)
        
        do {
            try context.save()
        }
        catch let error {
            print("Could not save because of \(error).")
        }
    }
    
    func calculateAmounts(for cellType: BudgetInputCellType, input: Double) {
        
        if cellType == .yearlyAllowance {
            newInputAnnualBudgetAmount = input
            estimateSpentSoFarAmount()
        }
        else if cellType == .monthlyAllowance {
            newInputAnnualBudgetAmount = input * 12.0
            estimateSpentSoFarAmount()
        }
        else if cellType == .usedUp {
            newInputAnnualSpentAmount = input
        }

    }
    
    // MARK: - Private Methods
    
    private func estimateSpentSoFarAmount() {
        
        let month = Calendar.current.component(.month, from: Date()) - 1
        newInputAnnualSpentAmount = Double(month) * (newInputAnnualBudgetAmount / 12.0)
    }
    
    private func resetNewBudgetAttributes() {
        
        selectedBudgetType = nil
        newInputAnnualSpentAmount = 0.0
        newInputAnnualBudgetAmount = 0.0
    }

}
