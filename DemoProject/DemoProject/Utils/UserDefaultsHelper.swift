//
//  UserDefaultsHelper.swift
//  DemoProject
//
//  Created by Avinash Sharma on 16/01/23.
//

import Foundation

enum UserDefaultKeys: String, CaseIterable {
	case isUserLoggedIn
}

final class UserDefaultsHelper {
	
	static func setObject<T>(value: T, key: UserDefaultKeys) {
		let defaults = UserDefaults.standard
		defaults.set(value, forKey: key.rawValue)
	}
	
	static func getObject<T>(type: T.Type, forKey: UserDefaultKeys) -> T? {
		let defaults = UserDefaults.standard
		let value = defaults.object(forKey: forKey.rawValue) as? T
		return value
	}
	
	/// if the value exists for the given `key` it will return `true` if not then `false`
	static func has(forKey: UserDefaultKeys) -> Bool {
		let defaults = UserDefaults.standard
		let value = defaults.object(forKey: forKey.rawValue)
		if value == nil {
			return false
		} else {
			return true
		}
	}
	
	static func removeObject(key: UserDefaultKeys) {
		let defaults = UserDefaults.standard
		defaults.removeObject(forKey: key.rawValue)
	}
	
	static func removeAllObject() {
		UserDefaultKeys.allCases.forEach({
			self.removeObject(key: $0)
		})
	}
}
