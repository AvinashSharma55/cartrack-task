//
//  UserGeoLocation.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//


import Foundation


struct UserGeoLocation : Codable {
	
	var latitude : String?
	var longitude : String?
	
	enum CodingKeys: String, CodingKey {
		case latitude = "lat"
		case longitude = "lng"
	}
}

extension UserGeoLocation {
	init(from decoder : Decoder) throws {
		do{
			let values = try decoder.container(keyedBy: CodingKeys.self)
			latitude = try? values.decodeIfPresent(String.self, forKey: .latitude)
			longitude = try? values.decodeIfPresent(String.self, forKey: .longitude)
		} catch { print("Failed to decode UserGeoLocation from response") }
	}
}

extension UserGeoLocation {
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try? container.encodeIfPresent(latitude, forKey: .latitude)
		try? container.encodeIfPresent(longitude, forKey: .longitude)
	}
}
