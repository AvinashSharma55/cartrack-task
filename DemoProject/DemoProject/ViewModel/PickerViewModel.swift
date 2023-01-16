//
//  PickerViewModel.swift
//  DemoProject
//
//  Created by Avinash Sharma on 15/01/23.
//

import Foundation

class PickerViewModel {
	private (set) var countryDataSource : [CountryModel]?
		
	private (set) var filterCountryDataSource : [CountryModel]?
	
	private (set) var selectedCountryModel : CountryModel? {
		didSet {
			self.onSuccesfullySelectingCountry?(selectedCountryModel)
		}
	}

	var onSuccesfullySelectingCountry : ((CountryModel?)->())?
	
	init(dataSource : [CountryModel]? , selectedData : CountryModel?) {
		countryDataSource = dataSource
		selectedCountryModel = selectedData
		filterCountryDataSource = dataSource
	}
	
	func selectCountry(didSelectRow : Int? , isSearchActive : Bool) {
		guard let row = didSelectRow , let dataSource = countryDataSource else { return }
		if isSearchActive {
			guard let filterDataSource = filterCountryDataSource else { return }
			selectedCountryModel = filterDataSource[row]
		}
		else {
			selectedCountryModel = dataSource[row]
		}
	}
	
	func filterCountriesBasedOnText(text : String?) {
		guard let searchText = text  else { return }
		if searchText.count == 0 {
			filterCountryDataSource = countryDataSource
		}
		else {
			filterCountryDataSource = countryDataSource?.filter {
				return ($0.name?.lowercased().contains(searchText.lowercased()) ?? false)
			}
		}
	}
}
