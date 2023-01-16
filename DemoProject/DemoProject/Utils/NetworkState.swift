//
//  NetworkState.swift
//  DemoProject
//
//  Created by Avinash Sharma on 16/01/23.
//

import Foundation
import Alamofire

class NetworkState {
	class func isConnected() ->Bool {
		return NetworkReachabilityManager()!.isReachable
	}
}


