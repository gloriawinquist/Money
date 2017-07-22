//
//  MenuTableViewCell.swift
//  Money
//
//  Created by Gloria Winquist on 7/15/17.
//  Copyright © 2017 glow. All rights reserved.
//

import UIKit

// TableViewCell that displays a menu item in the menu view controller
final class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var menuIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clearContents()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearContents()
    }
    
    // MARK: - Public Methods
    
    func configure(with item: MenuViewModel.MenuItem) {
        titleLabel.text = item.displayString
    }
    
    // MARK: - Private Methods
    
    private func clearContents() {
        titleLabel.text = nil
    }
    
}
