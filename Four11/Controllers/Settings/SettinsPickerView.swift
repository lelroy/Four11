//
//  SettinsPickerView.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-26.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit

extension SettingsViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        country = countries[row]
        countryPickerView.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let color = (row == pickerView.selectedRow(inComponent: component)) ? COLORS.TERTIARY : COLORS.SECONDARY
        return NSAttributedString(string: self.countries[row], attributes: [NSAttributedString.Key.foregroundColor:color])
    }
    
    
    
}
