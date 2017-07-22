//
//  BudgetInputViewController.swift
//  Money
//
//  Created by Gloria Winquist on 7/16/17.
//  Copyright © 2017 glow. All rights reserved.
//

import UIKit

// The BudgetInputViewController is used to add budget items to the app
final class BudgetInputViewController: UIViewController {
    
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    @IBOutlet private weak var theTableView: UITableView!
    
    var viewModel: BudgetsViewModel?
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableSaveButton()
        setUpTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let budgetTypesViewController = segue.destination as? BudgetTypesTableViewController {
            
            budgetTypesViewController.viewModel = viewModel
            budgetTypesViewController.budgetTypeSelectedClosure = { [weak self] budgetType in
                
                self?.theTableView.reloadData()
                self?.enableSaveButton()
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func handleCancelTapped(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSaveTapped(_ sender: UIBarButtonItem) {
        
        viewModel?.createBudgetItem()
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Private Methods
    
    private func enableSaveButton() {
        
        saveButton.isEnabled = viewModel?.selectedBudgetType != nil
    }
    
    private func setUpTableView() {
        
        theTableView.rowHeight = UITableViewAutomaticDimension
        theTableView.estimatedRowHeight = 60.0
        theTableView.tableFooterView = UIView()
    }
    
}

extension BudgetInputViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = viewModel else {
            return UITableViewCell()
        }
        
        // BUDGET TYPE
        if indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "budgetTypeCellId", for: indexPath) as? BudgetSelectionTableViewCell {
            cell.configure(with: model.selectedBudgetType?.rawValue)
            return cell
        }
        
        // BUDGET ALLOWANCE
        if indexPath.section == 1, let cell = tableView.dequeueReusableCell(withIdentifier: "budgetInputTextCellId", for: indexPath) as? BudgetInputTextTableViewCell  {

            let cellType: BudgetsViewModel.BudgetInputCellType = (indexPath.row == 0) ? .yearlyAllowance : .monthlyAllowance
            
            if cellType == .yearlyAllowance {
                cell.configure(withLabel: cellType.displayLabel, textFieldText: String(format: "%0.2f", model.newInputAnnualBudgetAmount))
                cell.textFieldAmountChanged = { [weak self] doubleValue in
                    
                    self?.viewModel?.calculateAmounts(for: cellType, input: doubleValue)
                    // reload the monthly allowance row and the amount already spent row
                    tableView.reloadRows(at: [IndexPath(row: 1, section: 1), IndexPath(row: 0, section: 2)], with: .automatic)
                }
            }
            else {
                cell.configure(withLabel: cellType.displayLabel, textFieldText: String(format: "%0.2f", (model.newInputAnnualBudgetAmount / 12.0)))
                cell.textFieldAmountChanged = { [weak self] doubleValue in
                    
                    self?.viewModel?.calculateAmounts(for: cellType, input: doubleValue)
                    // reload the yearly allowance row and the amount already spent row
                    tableView.reloadRows(at: [IndexPath(row: 0, section: 1), IndexPath(row: 0, section: 2)], with: .automatic)
                }
            }
            return cell
        }
        
        // AMOUNT ALREADY SPENT
        if indexPath.section == 2, let cell = tableView.dequeueReusableCell(withIdentifier: "budgetInputTextCellId", for: indexPath) as? BudgetInputTextTableViewCell {
            
            let cellType: BudgetsViewModel.BudgetInputCellType = .usedUp
            cell.configure(withLabel: cellType.displayLabel, textFieldText: String(format: "%0.2f", (model.newInputAnnualSpentAmount)))
            cell.textFieldAmountChanged = { [weak self] doubleValue in
                self?.viewModel?.calculateAmounts(for: cellType, input: doubleValue)
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension BudgetInputViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            performSegue(withIdentifier: "showBudgetTypeSelectionSegue", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30.0
    }
}


