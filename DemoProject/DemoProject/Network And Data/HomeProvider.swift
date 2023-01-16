//
//  HomeProvider.swift
//  DemoProject
//
//  Created by Avinash Sharma on 15/01/23.
//

import Foundation
import Moya

public enum HomeProvider {
	case fetchHomeData
	
}

extension HomeProvider : TargetType {
	public var baseURL: URL {
		return URL(string : APIConstants.baseUrl)!
	}
	
	public var path: String {
		switch self {
		case .fetchHomeData:
			return APIConstants.fetchUsersPath
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .fetchHomeData:
			return .get
		}
	}
	
	public var sampleData: Data {
		return Data()
	}
	
	public var task: Task {
		switch self {
		case .fetchHomeData :
			return .requestParameters(parameters: [:], encoding: URLEncoding.default)
		}
	}
	
	public var headers: [String : String]? {
	   return nil
	}
	
	public var validationType: ValidationType {
	  return .successCodes
	}
}

