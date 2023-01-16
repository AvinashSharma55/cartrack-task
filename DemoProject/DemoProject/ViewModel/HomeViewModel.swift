//
//  HomeViewModel.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//

import Foundation
import Moya
import UIKit

class HomeViewModel {
	
	private let homeProvider = MoyaProvider<HomeProvider>()
	private (set) var users : [UserModel]! {
		didSet {
			onSuccessfullyFetchingData?(users)
		}
	}
	var onSuccessfullyFetchingData : (([UserModel]?)->())?
	private var onErroFetchingData : ((APIError)->())?
	private var showLoaderToStartFetching : (()->())?
	
	init(loadingBlock : (()->())? , errorLoadingBlock : ((APIError?)->())?) {
		showLoaderToStartFetching = loadingBlock
		onErroFetchingData = errorLoadingBlock
		fetchUserData()
	}
	
	private func fetchUserData() {
		if NetworkState.isConnected() {
			self.showLoaderToStartFetching?()
			homeProvider.request(.fetchHomeData) { [weak self] result in
				guard let _ = self else { return }
					switch result {
					case .success(let response):
						do {
							let users = try response.map([UserModel].self)
							self?.users = users
						}
						catch {
							self?.onErroFetchingData?(.server)
						}
					case .failure( _ ):
							self?.onErroFetchingData?(.server)
					}
			}
		}
		else {
			onErroFetchingData?(.network)
		}
	}
	
	func retryFetchingUsers() {
		fetchUserData()
	}
}
