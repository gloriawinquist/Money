//
//  BudgetTableViewCell.swift
//  Money
//
//  Created by Gloria Winquist on 7/16/17.
//  Copyright © 2017 glow. All rights reserved.
//

import UIKit

/// Class that displays a budget item in the tableview of the BudgetsViewController. Two trackers show the ratio of amount spent vs budgeted.
final class BudgetTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var mainLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!
    @IBOutlet private weak var spentLabel: UILabel!
    @IBOutlet private weak var remainingLabel: UILabel!
    @IBOutlet private weak var monthlySpentWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var annnualSpentWidthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        clearContents()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearContents()
    }
    
    // MARK: - Public Methods
    
    func configure(with budget: Budget) {
        
        mainLabel.text = budget.budgetType
        budgetLabel.text = String(format: "%.02f", budget.monthlyAllowance)
        spentLabel.text = String(format: "%.02f", budget.monthlySpent)
        remainingLabel.text = String(format: "%.02f", budget.monthlyRemaining)
        
        if budget.yearlyAllowance > 0 {
            
            // full width is frame width minus padding and 2 pixel black bar
            let fullSpentWidth = frame.width - 12.0
            monthlySpentWidthConstraint.constant = CGFloat(budget.monthlySpentRatio) * fullSpentWidth
            annnualSpentWidthConstraint.constant = CGFloat(budget.annualSpentRatio) * fullSpentWidth
            setNeedsUpdateConstraints()
            layoutIfNeeded()
        }
        else {
            monthlySpentWidthConstraint.constant = 0.0
            annnualSpentWidthConstraint.constant = 0.0
            setNeedsUpdateConstraints()
            layoutIfNeeded()
        }
        
    }
    
    // MARK: - Private Methods

    private func clearContents() {
        
        mainLabel.text = nil
        budgetLabel.text = nil
        spentLabel.text = nil
        remainingLabel.text = nil
        monthlySpentWidthConstraint.constant = 0.0
        annnualSpentWidthConstraint.constant = 0.0
    }
    
}
