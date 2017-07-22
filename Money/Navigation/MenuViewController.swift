//
//  MenuViewController.swift
//  Money
//
//  Created by Gloria Winquist on 7/15/17.
//  Copyright © 2017 glow. All rights reserved.
//

import UIKit

// Class that displays the menu for the app. Is slid out on the left using SWRevealController.
final class MenuViewController: UIViewController {
    
    @IBOutlet private weak var theTableView: UITableView!
    
    let viewModel = MenuViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }

    // MARK: - Private Methods
    
    private func setUpTableView() {
        
        theTableView.rowHeight = UITableViewAutomaticDimension
        theTableView.estimatedRowHeight = 40.0
        theTableView.tableFooterView = UIView()
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCellId", for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.row < viewModel.items.count {
            
            let menuItem = viewModel.items[indexPath.row]
            cell.configure(with: menuItem)
        }
        
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if indexPath.row < viewModel.items.count {
            performSegue(withIdentifier: viewModel.items[indexPath.row].segue, sender: nil)
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


