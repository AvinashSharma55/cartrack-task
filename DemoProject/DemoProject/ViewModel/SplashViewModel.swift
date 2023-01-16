//
//  SplashViewModel.swift
//  DemoProject
//
//  Created by Avinash Sharma on 16/01/23.
//

import Foundation

class SplashViewModel {
	
	private (set) var loggedInStatus : Bool! {
		didSet {
			returnLoggedInStatus?(loggedInStatus)
		}
	}
	private var returnLoggedInStatus : ((Bool)->())?
	
	
	init(onCheckCompletion : ((Bool)->())?) {
		returnLoggedInStatus = onCheckCompletion
		checkLoggedInStatus()
	}
	
	func checkLoggedInStatus() {
		let status = UserDefaultsHelper.getObject(type: Bool.self, forKey: .isUserLoggedIn)
		loggedInStatus = status ?? false
	}
	
	
}
