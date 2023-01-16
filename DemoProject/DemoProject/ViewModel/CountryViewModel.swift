//
//  CountryViewModel.swift
//  DemoProject
//
//  Created by Avinash Sharma on 15/01/23.
//

import Foundation


class CountryViewModel {
	
	private (set) var countryDataSource : [CountryModel]?
	
	private var countryProvider  : CountryProvider!
	
	private (set) var  selectedCountry : CountryModel? {
		didSet {
			self.onCountrySelection?(selectedCountry?.flag)
		}
	}
	
	var onCountrySelection : ((String?)->())?
	
	init() {
		countryProvider = CountryProvider()
		fetchCountries()
	}
	
	private func fetchCountries() {
		countryDataSource = countryProvider.getListOfCountries()
	}
	
	
	func selectDefaultCountry() {
		guard let dataSource = countryDataSource else { return }
		selectedCountry = dataSource[0]
	}
	
	func didSelectCountry(country : CountryModel?) {
		guard let selectedData = country else { return }
		selectedCountry = selectedData
	}
	
	func getPickerViewModel() -> PickerViewModel {
		PickerViewModel.init(dataSource: countryDataSource, selectedData: selectedCountry)
	}

}
