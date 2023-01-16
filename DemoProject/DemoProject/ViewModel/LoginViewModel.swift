//
//  LoginViewModel.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//

import Foundation

class LoginViewModel  {
	
	private var databaseProvider : DatabaseProvider!
	private (set) var validationState : LoginValidationResults!
	
	var onValidationOfLoginValues : ((LoginValidationResults)->())?

	
	init() {
		databaseProvider = DatabaseProvider()
	}
	
	func validateUserNameAndPassword(userName : String? , password : String?) {
		if (((userName ?? "").count == 0) && ((password ?? "").count == 0)){
			validationState = .emptyUserNameAndPassword
			self.onValidationOfLoginValues?(.emptyUserNameAndPassword)
		}
		else if (userName ?? "").count == 0 {
			validationState = .emptyUserName
			self.onValidationOfLoginValues?(.emptyUserName)
		}
		else if (password ?? "").count == 0 {
			validationState = .emptyPassword
			self.onValidationOfLoginValues?(.emptyPassword)
		}
		else {
			if databaseProvider.database == nil {
				validationState = .databaseError
				self.onValidationOfLoginValues?(.databaseError)
			}
			else {
				let databaseResults =  databaseProvider.checkIfUserExists(userName: userName ?? "")
				switch databaseResults.1 {
					case .error :
						validationState = .databaseError
						self.onValidationOfLoginValues?(.databaseError)
						break
					case .success :
						let loginUser = databaseResults.0
						if ((loginUser?.password ?? "") == (password ?? "")) {
							validationState = .validationSuccess
							self.onValidationOfLoginValues?(.validationSuccess)
							UserDefaultsHelper.setObject(value: true, key: .isUserLoggedIn)
						}
						else {
							validationState = .invalidPassword
							self.onValidationOfLoginValues?(.invalidPassword)
						}
						break
					case .noResults :
						validationState = .invalidUsername
						self.onValidationOfLoginValues?(.invalidUsername)
						break
				}
			}
		}
	}
	
	func getTextBasedOnValidationResult(loginValidationResult : LoginValidationResults , field : LoginFields) -> String {
		switch (loginValidationResult , field) {
			case (.invalidUsername , .username):
				return StringConstants.invalidUserNameErrorMessage
			case (.invalidPassword , .password):
				return StringConstants.invalidPasswordErrorMessage
			case (.databaseError , .username):
				return StringConstants.userNameErrorMessage
			case (.emptyUserName , .username):
				return StringConstants.emptyUsernameErrorMessage
			case (.emptyPassword , .password):
				return StringConstants.emptyPasswordErrorMessage
			case (.emptyUserNameAndPassword , .username):
				return StringConstants.emptyUsernameErrorMessage
			case (.emptyUserNameAndPassword , .password) :
				return StringConstants.emptyPasswordErrorMessage
			default :
				return ""
		}
	}
}
