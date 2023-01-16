//
//  CountryProvider.swift
//  DemoProject
//
//  Created by Avinash Sharma on 15/01/23.
//

import Foundation

class CountryProvider : NSObject {
	
	override init() {
		super.init()
	}
	
	func getListOfCountries() -> [CountryModel]? {
		var countries = [CountryModel]()
		for code in NSLocale.isoCountryCodes  {
            let flag = String.emojiFlag(for: code)
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
			if let countryName = NSLocale(localeIdentifier: NSLocale.current.identifier).displayName(forKey: NSLocale.Key.identifier, value: id) , let flagName =   flag {
				countries.append(CountryModel(name: countryName, flag: flagName))
            }
        }
		return countries
	}
}
