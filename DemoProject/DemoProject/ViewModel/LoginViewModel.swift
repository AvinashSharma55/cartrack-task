//
//  LoginViewModel.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//

import Foundation

class LoginViewModel  {
	
	private var databaseProvider : DatabaseProvider!
	
	var onValidationOfLoginValues : ((LoginValidationResults)->(Bool))?

	
	init() {
		databaseProvider = DatabaseProvider()
	}
	
	func validateUserNameAndPassword(userName : String? , password : String?) {
		if (((userName ?? "").count == 0) && ((password ?? "").count == 0)){
			let _ = self.onValidationOfLoginValues?(.emptyUserNameAndPassword)
		}
		else if (userName ?? "").count == 0 {
			_ =  self.onValidationOfLoginValues?(.emptyUserName)
		}
		else if (password ?? "").count == 0 {
			 _  = self.onValidationOfLoginValues?(.emptyPassword)
		}
		else {
			if databaseProvider.database == nil {
				_  = self.onValidationOfLoginValues?(.databaseError)
			}
			else {
				let databaseResults =  databaseProvider.checkIfUserExists(userName: userName ?? "")
				switch databaseResults.1 {
					case .error :
						_ = self.onValidationOfLoginValues?(.databaseError)
						break
					case .success :
						let loginUser = databaseResults.0
						if ((loginUser?.password ?? "") == (password ?? "")) {
							let val = self.onValidationOfLoginValues?(.validationSuccess)
							UserDefaultsHelper.setObject(value: val, key: .isUserLoggedIn)
						}
						else {
							_  = self.onValidationOfLoginValues?(.invalidPassword)
						}
						break
					case .noResults :
						_ = self.onValidationOfLoginValues?(.invalidUsername)
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
