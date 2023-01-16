//
//  Enums.swift
//  DemoProject
//
//  Created by Avinash Sharma on 16/01/23.
//

import Foundation

public enum DatabaseResults {
	case noResults
	case error
	case success
}

public enum LoginValidationResults : String {
	case invalidUsername
	case invalidPassword
	case databaseError
	case emptyUserName
	case emptyPassword
	case validationSuccess
	case emptyUserNameAndPassword
}

public enum LoginFields {
	case username
	case password
}

public enum APIState  {
	case network
	case server
	case loading
}
