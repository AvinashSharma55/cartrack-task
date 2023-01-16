//
//  DBProvider.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//

import Foundation
import SQLite3

class DatabaseProvider
{
	let dataBasePath : String = StringConstants.databasePath
	var database : OpaquePointer?
	var errorProcessingQuery : ((String?)->())?
	var successfullyProcessedQueryWithResult : ((LoginUser?)->())?
	
	
	init(){

		database = establishDataBaseConnection()
	}

	func establishDataBaseConnection() -> OpaquePointer?
	{
		var localDataBase: OpaquePointer? = nil
		do {
			let dataBaseFileUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
				.appendingPathComponent(dataBasePath)
			if sqlite3_open_v2(dataBaseFileUrl.path, &localDataBase, SQLITE_OPEN_READWRITE, nil) == SQLITE_OK {
				return localDataBase
			}
			else {
				sqlite3_close(database)
				guard let databaseUrl = Bundle.main.url(forResource: "users", withExtension: "db") else { return nil }
				do {
					try FileManager.default.copyItem(at: databaseUrl, to: dataBaseFileUrl)
					if sqlite3_open_v2(dataBaseFileUrl.path, &localDataBase, SQLITE_OPEN_READWRITE, nil) == SQLITE_OK {
						return localDataBase
					}
				}
				catch {
					return nil
				}
			}
		}
		catch( _ ) {
			return nil
		}
		return localDataBase
	}
	
	func checkIfUserExists(userName : String) -> (LoginUser? , DatabaseResults) {
		var loginUser : LoginUser?
		var databaseResult : DatabaseResults = .success
		let queryStatementString = "SELECT * FROM user WHERE username = ?"
		var queryStatement: OpaquePointer? = nil
		if sqlite3_prepare_v2(database, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
			if sqlite3_bind_text(queryStatement!, 1, userName, -1, nil) == SQLITE_OK {
				if sqlite3_step(queryStatement) == SQLITE_ROW {
					let id = Int(sqlite3_column_int(queryStatement, 0))
					let userName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
					let userPassword = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
					loginUser = LoginUser(id: id, username: userName, password: userPassword)
				}
				else {
					databaseResult = .noResults
				}
			}
			else {
				databaseResult = .error
			}
		}
		else {
			databaseResult = .error
		}
		sqlite3_finalize(queryStatement)
		return (loginUser,databaseResult)
	}
	
}
