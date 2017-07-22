//
//  MenuModel.swift
//  Money
//
//  Created by Gloria Winquist on 7/15/17.
//  Copyright © 2017 glow. All rights reserved.
//

import Foundation

// The MenuViewModel class contains the MenuItem enum that is used to populate the app menu.
final class MenuViewModel {
    
    enum MenuItem: Int {
        
        case home = 0
        case goals
        case budgets
        case transactions
        case accounts
        case settings
        
        static let all: [MenuItem] = [.home, .goals, .budgets, .transactions, .accounts, .settings]
        
        var displayString: String {
            
            switch self {
                
            case .home:
                return "Home"
            case .goals:
                return "Goals"
            case .budgets:
                return "Budgets"
            case .transactions:
                return "Transactions"
            case .accounts:
                return "Accounts"
            case .settings:
                return "Settings"
            }
        }
        
        var segue: String {
            
            switch self {
                
            case .home:
                return "showHomeSegue"
            case .goals:
                return "showGoalsSegue"
            case .budgets:
                return "showBudgetsSegue"
            case .transactions:
                return "showTransactionsSegue"
            case .accounts:
                return "showAccountsSegue"
            case .settings:
                return "showSettingsSegue"
            }
        }
    }
    
    let items = MenuItem.all
    
}
