//
//  BudgetsViewController.swift
//  Money
//
//  Created by Gloria Winquist on 7/15/17.
//  Copyright © 2017 glow. All rights reserved.
//

import UIKit

/// View Controller that displays a list of budgets in a tableView. New budgets can be added via a plus button that opens up a modal BudgetInputViewController.
final class BudgetsViewController: BaseViewController {
    
    @IBOutlet private weak var theTableView: UITableView!
    
    var viewModel = BudgetsViewModel()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.fetchBudgetItems()
        showOrHideTable()
        theTableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navigationController = segue.destination as? UINavigationController, let budgetInputViewController = navigationController.topViewController as? BudgetInputViewController {
            budgetInputViewController.viewModel = viewModel
        }
    }
    
    // MARK: - Private Methods
    
    private func setUpTableView() {
        
        theTableView.rowHeight = UITableViewAutomaticDimension
        theTableView.estimatedRowHeight = 120.0
        theTableView.tableFooterView = UIView()
    }
    
    /// Show or Hide the table based on whether there are budgets in the app.
    private func showOrHideTable() {
        theTableView.isHidden = viewModel.budgets.count < 1
    }

}

// MARK: - UITableViewDataSource

extension BudgetsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.budgets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // BUDGET SUMMARY
        if indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "totalsCellId", for: indexPath) as? BudgetSummaryTableViewCell {
            
            let budgetSummary = viewModel.createBudgetSummary()
            cell.configure(with: budgetSummary)
            return cell
        }

        // BUDGETS SECTION
        if indexPath.section == 1, viewModel.budgets.count > indexPath.row, let cell = tableView.dequeueReusableCell(withIdentifier: "budgetCellId", for: indexPath) as? BudgetTableViewCell {
            
            let budget = viewModel.budgets[indexPath.row]
            cell.configure(with: budget)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if indexPath.section == 1 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && viewModel.budgets.count > indexPath.row {
            
            let budget = viewModel.budgets[indexPath.row]
            viewModel.delete(budget: budget, at: indexPath)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            tableView.endUpdates()
            
            showOrHideTable()
        }
        
    }
}

extension BudgetsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Summary"
        }
        else {
            return "Budget Items"
        }
    }
    
}


