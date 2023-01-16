//
//  PickerViewController.swift
//  DemoProject
//
//  Created by Avinash Sharma on 15/01/23.
//

import UIKit

final class PickerViewController: UIViewController {
	
	private var containerView : UIView!
	private var pickerTableView : UITableView!
	private var searchController : UISearchController!
	private var topView : UIView!
	private var onSelectingCountry : ((CountryModel?)->())?

	private var pickerViewModel : PickerViewModel!
	
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	init(viewModel : PickerViewModel) {
		super.init(nibName: nil, bundle: nil)
		pickerViewModel = viewModel
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setUpView()
	}
	
	func setUpView() {
		
		view.backgroundColor = .clear
		view.isUserInteractionEnabled = true
		
		containerView = UIView()
		containerView.translatesAutoresizingMaskIntoConstraints = false
		containerView.backgroundColor = HelperFunctions.getBlackColor(alpha: 0.63)
		containerView.layer.cornerRadius  = 33.0
		containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		containerView.isUserInteractionEnabled = true
		
		view.addSubview(containerView)
		
		containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
		containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive = true
		containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
		containerView.heightAnchor.constraint(equalToConstant: (view.frame.height * 0.6)).isActive = true
		
		
		topView = UIView()
		topView.translatesAutoresizingMaskIntoConstraints = false
		topView.backgroundColor = HelperFunctions.countryTopViewColor()
		topView.layer.masksToBounds = true
		topView.layer.cornerRadius = 4.0
		
		containerView.addSubview(topView)
		
		
		searchController  = UISearchController.init(searchResultsController: nil)
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.barTintColor = HelperFunctions.getBlackColor(alpha: 0.63)
		searchController.searchBar.placeholder = StringConstants.searchBarPlaceholderText
		UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white , NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)]
		
		
		pickerTableView = UITableView()
		pickerTableView.translatesAutoresizingMaskIntoConstraints = false
		pickerTableView.backgroundColor = .clear
		pickerTableView.tableHeaderView = searchController.searchBar
		pickerTableView.tableFooterView = UIView.init(frame: .zero)
		pickerTableView.showsVerticalScrollIndicator = false
		pickerTableView.delegate = self
		pickerTableView.dataSource = self
		pickerTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.reuseIdentifier)
		pickerTableView.separatorStyle = .singleLine
		pickerTableView.separatorColor = HelperFunctions.getLoginContainerViewsBorderColor()
		pickerTableView.isUserInteractionEnabled = true
		containerView.addSubview(pickerTableView)
		
		topView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0.0).isActive = true
		topView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 11.0).isActive = true
		topView.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
		topView.widthAnchor.constraint(equalToConstant: 63.0).isActive = true
		
		pickerTableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20.0).isActive = true
		pickerTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0.0).isActive = true
		pickerTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0.0).isActive = true
		pickerTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0.0).isActive = true
		
		let viewTap = UITapGestureRecognizer.init(target: self, action: #selector(dismissView(_:)))
		viewTap.numberOfTapsRequired = 1
		viewTap.delegate = self
		view.addGestureRecognizer(viewTap)


		let containerViewTap = UITapGestureRecognizer.init(target: self, action: #selector(dismissView(_:)))
		containerViewTap.numberOfTapsRequired = 1
		containerViewTap.delegate = self
		containerView.addGestureRecognizer(containerViewTap)
		
		
		pickerViewModel.onSuccesfullySelectingCountry = {
			[weak self] country in
			self?.onSelectingCountry?(country)
		}
		
		pickerTableView.reloadData()
	}
	
	@objc func dismissView(_ sender : Any?) {
		dismiss(animated: true)
	}
	
	

}

extension PickerViewController : UITableViewDelegate , UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		pickerViewModel.selectCountry(didSelectRow: indexPath.row , isSearchActive: searchController.isActive)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44.0
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchController.isActive ? (pickerViewModel.filterCountryDataSource?.count ?? 0) :  (pickerViewModel.countryDataSource?.count ?? 0)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseIdentifier, for: indexPath) as? CountryTableViewCell
		if searchController.isActive {
			cell?.setUpCell(country: pickerViewModel.filterCountryDataSource?[indexPath.row], selectedCountry: pickerViewModel.selectedCountryModel?.name)
		}
		else {
			cell?.setUpCell(country: pickerViewModel.countryDataSource?[indexPath.row], selectedCountry: pickerViewModel.selectedCountryModel?.name)
		}
		
		return cell ?? UITableViewCell()
	}

}

extension PickerViewController : UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		pickerViewModel.filterCountriesBasedOnText(text: searchController.searchBar.text)
		pickerTableView.reloadData()
	}
	
	
}

extension PickerViewController : UIGestureRecognizerDelegate {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		return !(view.hitTest(touch.location(in: view), with: nil)?.isDescendant(of: pickerTableView) == true)
	}
}
