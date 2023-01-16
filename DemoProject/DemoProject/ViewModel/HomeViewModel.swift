//
//  HomeViewModel.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//

import Foundation
import Moya
import CoreLocation

class HomeViewModel : NSObject {
	
	private let homeProvider = MoyaProvider<HomeProvider>()
	private (set) var users : [UserModel]! {
		didSet {
			convertUsersToAnnotation()
		}
	}
	var onSuccessfullyFetchingData : (([UserAnnotation]?)->())?
	private var loaderShowingBlock : ((APIState)->())?
	
	
	init(loading : ((APIState)->())?) {
		super.init()
		loaderShowingBlock = loading
		fetchUserData()
	}
	
	private func fetchUserData() {
		if NetworkState.isConnected() {
			self.loaderShowingBlock?(.loading)
			homeProvider.request(.fetchHomeData) { [weak self] result in
				guard let _ = self else { return }
					switch result {
					case .success(let response):
						do {
							let users = try response.map([UserModel].self)
							self?.users = users
						}
						catch {
							self?.loaderShowingBlock?(.server)
						}
					case .failure( _ ):
							self?.loaderShowingBlock?(.server)
					}
			}
		}
		else {
			loaderShowingBlock?(.network)
		}
	}
	
	func retryFetchingUsers() {
		fetchUserData()
	}
	
	func convertUsersToAnnotation() {
		var annotations = [UserAnnotation]()
		for user in users ?? [] {
			let annotation  = UserAnnotation(name: user.name, coordinate: CLLocationCoordinate2D(latitude: (Double(user.address?.geoLocation?.latitude ?? "") ?? 0.0), longitude: (Double(user.address?.geoLocation?.longitude ?? "") ?? 0.0)) , userName:  user.username , companyName: user.company?.name , address: user.address)
			annotations.append(annotation)
		}
		onSuccessfullyFetchingData?(annotations)
	}
}
