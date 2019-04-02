//
//  MenuViewController.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-25.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit


protocol ChangeCountryDelegate {
    func newCountry(country:String)
}

class SettingsViewController: UIViewController {

 
    
    
    @IBOutlet weak var countryPickerView: UIPickerView!
    var delegate: ChangeCountryDelegate?
    var country = ""
    var countries = ["Argentina", "Australia", "Austria", "Belgium", "Brazil", "Bulgaria", "Canada", "China", "Colombia", "Cuba", "Czech Republic", "Egypt", "France", "Germany", "Greece", "Hong Kong", "Hungary", "India", "Indonesia", "Ireland", "Israel", "Italy", "Japan", "Latvia", "Lithuania", "Malaysia", "Mexico", "Morocco", "Netherlands", "New Zealand", "Nigeria", "Norway", "Philippines", "Poland", "Portugal", "Romania", "Russia", "Saudi Arabia", "Serbia", "Singapore", "Slovakia", "Slovenia", "South Africa", "South Korea", "Sweden","Switzerland", "Taiwan", "Thailand", "Turkey", "UAE", "Ukraine", "United States", "United Kingdom", "Venezuela"]
    
    var countriesDictionaryReversed = [API_COUNTRY.ARGENTINA:"Argentina",
                                       API_COUNTRY.AUSTRALIA:"Australia",
                                       API_COUNTRY.AUSTRIA:"Austria",
                                       API_COUNTRY.BELGIUM:"Aelgium",
                                       API_COUNTRY.BRAZIL:"Brazil",
                                       API_COUNTRY.BULGARIA:"Bulgaria",
                                       API_COUNTRY.CANADA:"Canada",
                                       API_COUNTRY.CHINA:"China",
                                       API_COUNTRY.COLOMBIA:"Colombia",
                                       API_COUNTRY.CUBA:"Cuba",
                                       API_COUNTRY.CZECH_REPUBLIC:"Czech Republic",
                                       API_COUNTRY.EGYPT:"Egypt",
                                       API_COUNTRY.FRANCE:"France",
                                       API_COUNTRY.GERMANY:"Germany",
                                       API_COUNTRY.GREECE:"Greece",
                                       API_COUNTRY.HONG_KONG:"Hong Kong",
                                       API_COUNTRY.HUNGARY:"Hungary",
                                       API_COUNTRY.INDIA:"India",
                                       API_COUNTRY.INDONESIA:"Indonesia",
                                       API_COUNTRY.IRELAND:"Ireland",
                                       API_COUNTRY.ISRAEL:"Israel",
                                       API_COUNTRY.ITALY:"Italy",
                                       API_COUNTRY.JAPAN:"Japan",
                                       API_COUNTRY.LATVIA:"Latvia",
                                       API_COUNTRY.LITHUANIA:"Lithuania",
                                       API_COUNTRY.MALAYSIA:"Malaysia",
                                       API_COUNTRY.MEXICO:"Mexico",
                                       API_COUNTRY.MOROCCO:"Morocco",
                                       API_COUNTRY.NETHERLANDS:"Netherlands",
                                       API_COUNTRY.NEW_ZEALAND:"New Zealand",
                                       API_COUNTRY.NIGERIA:"Nigeria",
                                       API_COUNTRY.NORWAY:"Norway",
                                       API_COUNTRY.PHILIPPINES:"Philippines",
                                       API_COUNTRY.POLAND:"Poland",
                                       API_COUNTRY.PORTUGAL:"Portugal",
                                       API_COUNTRY.ROMANIA:"Romania",
                                       API_COUNTRY.RUSSIA:"Russia",
                                       API_COUNTRY.SAUDI_ARABIA:"Saudi Arabia",
                                       API_COUNTRY.SERBIA:"Serbia",
                                       API_COUNTRY.SINGAPORE:"Singapore",
                                       API_COUNTRY.SLOVAKIA:"Slovakia",
                                       API_COUNTRY.SLOVENIA:"Slovenia",
                                       API_COUNTRY.SOUTH_AFRICA:"South Africa",
                                       API_COUNTRY.SOUTH_KOREA:"South Korea",
                                       API_COUNTRY.SWEDEN:"Sweden",
                                       API_COUNTRY.SWITZERLAND:"Switzerland",
                                       API_COUNTRY.TAIWAN:"Taiwan",
                                       API_COUNTRY.THAILAND:"Thailand",
                                       API_COUNTRY.TURKEY:"Turkey",
                                       API_COUNTRY.UAE:"UAE",
                                       API_COUNTRY.UKRAINE:"Ukraine",
                                       API_COUNTRY.UNITED_STATES:"United States",
                                       API_COUNTRY.UNITED_KINGDOM:"United Kingdom",
                                       API_COUNTRY.VENEZUELA:"Venezuela"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        
        guard let completeCountry = countriesDictionaryReversed[country] else {
            fatalError("Missing country in settings!")
        }
        
        if let indexCountry = countries.firstIndex(of: completeCountry) {
            countryPickerView.selectRow(indexCountry, inComponent: 0, animated: true)
        } else {
            countryPickerView.selectRow(6, inComponent: 0, animated: false)
        }
        
        //Set default country
        
        self.view.backgroundColor = COLORS.PRIMARY
        countryPickerView.setValue(COLORS.TERTIARY, forKey: "textColor")
       
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        
        delegate?.newCountry(country: country)
        self.dismiss(animated: true, completion: nil)
        
    }
    
        
}
