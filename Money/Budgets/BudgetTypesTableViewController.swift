//
//  BudgetTypesTableViewController.swift
//  Money
//
//  Created by Gloria Winquist on 7/16/17.
//  Copyright © 2017 glow. All rights reserved.
//

import UIKit

/// TableViewController used in budget type selection for inputing budget items. When a new budget type is selected, a closure is called to pass back the selected budget type and the BudgetTypesTableViewController dismisses itself
final class BudgetTypesTableViewController: UITableViewController {
    
    var viewModel: BudgetsViewModel?
    
    var budgetTypeSelectedClosure: ((BudgetsViewModel.BudgetType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    // MARK: - Private Methods
    
    private func setUpTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
        tableView.tableFooterView = UIView()
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let budgetTypes = viewModel?.budgetTypes else {
            return 0
        }
        return budgetTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let budgetTypes = viewModel?.budgetTypes, budgetTypes.count > indexPath.row else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetTypeSelectionCellId", for: indexPath)
        let budgetType = budgetTypes[indexPath.row]
        cell.textLabel?.text = budgetType.rawValue
        if let selectedType = viewModel?.selectedBudgetType, selectedType == budgetType {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let budgetTypes = viewModel?.budgetTypes, budgetTypes.count > indexPath.row else {
            return
        }
        
        let selectedType = budgetTypes[indexPath.row]
        viewModel?.selectedBudgetType = selectedType
        tableView.reloadData()
        budgetTypeSelectedClosure?(selectedType)
        navigationController?.popViewController(animated: true)
    }

}
