//
//  BudgetInputTextTableViewCell.swift
//  Money
//
//  Created by Gloria Winquist on 7/16/17.
//  Copyright © 2017 glow. All rights reserved.
//

import UIKit

/// Class that takes in text input (as a decimal number) for budget amounts.
final class BudgetInputTextTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var mainLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    var textFieldAmountChanged: ((Double) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        clearContents()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearContents()
    }
    
    // MARK: - Public Methods
    
    func configure(withLabel label: String, textFieldText: String?) {
        
        mainLabel.text = label
        
        if let text = textFieldText, let amount = Double(text), amount == 0 {
            textField.text = nil
        }
        else {
            textField.text = textFieldText
        }
        textField.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func clearContents() {
    
        mainLabel.text = nil
        textField.text = nil
    }
    
}

extension BudgetInputTextTableViewCell: UITextFieldDelegate {
    
    // Only allow for decimal numbers
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            if let text = textField.text as NSString?, let doubleValue = Double(text.replacingCharacters(in: range, with: string)) {
                textFieldAmountChanged?(doubleValue)
            }
            return true
        }
        else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    if let text = textField.text as NSString?, let doubleValue = Double(text.replacingCharacters(in: range, with: string)) {
                        textFieldAmountChanged?(doubleValue)
                    }
                    return true
                }
                else {
                    if countdots > 0 && string == "." {
                        return false
                    }
                    else {
                        if let text = textField.text as NSString?, let doubleValue = Double(text.replacingCharacters(in: range, with: string)) {
                            textFieldAmountChanged?(doubleValue)
                        }
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = nil
        return true
    }
    
}
