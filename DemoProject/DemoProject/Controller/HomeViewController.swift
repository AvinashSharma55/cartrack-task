//
//  HomeViewController.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//

import UIKit
import MapKit

final class HomeViewController: BaseViewController {
	
	private var homeViewModel : HomeViewModel!
	private var mapView : MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
		setUpViewModel()
    }
	
	func setUpViewModel() {
		
		homeViewModel = HomeViewModel(loadingBlock: {
			[weak self] in
			self?.loaderView.showActivityIndicator(uiView: self?.view ?? UIView())
		} , errorLoadingBlock: {
			[weak self] errorType in
			self?.loaderView.showErrorLabel(errorType: errorType ?? .server , uiView: self?.view ?? UIView())
		})
		homeViewModel.onSuccessfullyFetchingData = {
			[weak self] _ in
			self?.loaderView.hideActivityIndicator(uiView: self?.view ?? UIView())
		}
		loaderView.onActionButton = {
			[weak self] in
			self?.homeViewModel.retryFetchingUsers()
		}
	}
	
	func setUpView() {
		
	}
	
}
