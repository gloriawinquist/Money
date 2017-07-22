//
//  BudgetSummaryTableViewCell.swift
//  Money
//
//  Created by Gloria Winquist on 7/16/17.
//  Copyright © 2017 glow. All rights reserved.
//

import UIKit

/// TableViewCell that takes a BudgetSummary object and displays its properties in a table like format.
final class BudgetSummaryTableViewCell: UITableViewCell {

    @IBOutlet private weak var annualNetIncomeLabel: UILabel!
    @IBOutlet private weak var monthlyNetIncomeLabel: UILabel!
    
    @IBOutlet private weak var annualBudgetedLabel: UILabel!
    @IBOutlet private weak var monthlyBudgetedLabel: UILabel!
    
    @IBOutlet private weak var annualSavedLabel: UILabel!
    @IBOutlet private weak var monthlySavedLabel: UILabel!
   
    @IBOutlet private weak var annualRemainingLabel: UILabel!
    @IBOutlet private weak var monthlyRemainingLabel: UILabel!
    
    func configure(with summary: BudgetsViewModel.BudgetSummary) {
        
        annualNetIncomeLabel.text = String(format: "%.02f", summary.netAnnualIncome)
        monthlyNetIncomeLabel.text = String(format: "%.02f", summary.netMonthlyIncome)
        annualBudgetedLabel.text = String(format: "%.02f", summary.annualBudget)
        monthlyBudgetedLabel.text = String(format: "%.02f", summary.monthlyBudget)
        annualSavedLabel.text = String(format: "%.02f", summary.annualSaved)
        monthlySavedLabel.text = String(format: "%.02f", summary.monthlySaved)
        annualRemainingLabel.text = String(format: "%.02f", summary.annualRemaining)
        monthlyRemainingLabel.text = String(format: "%.02f", summary.monthlyRemaining)
        
    }
    
}
