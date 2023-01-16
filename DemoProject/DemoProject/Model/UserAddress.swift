//
//  UserAddress.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//

import Foundation


struct UserAddress : Codable {
	
	var street : String?
	var suite : String?
	var city : String?
	var zipcode : String?
	var geoLocation : UserGeoLocation?
	
	
	enum CodingKeys: String, CodingKey {
		case street
		case suite
		case city
		case zipcode
		case geoLocation = "geo"
	}
}

extension UserAddress {
	init(from decoder : Decoder) throws {
		do{
			let values = try decoder.container(keyedBy: CodingKeys.self)
			street = try? values.decodeIfPresent(String.self, forKey: .street)
			suite = try? values.decodeIfPresent(String.self, forKey: .suite)
			city = try? values.decodeIfPresent(String.self, forKey: .city)
			zipcode = try? values.decodeIfPresent(String.self, forKey: .zipcode)
			geoLocation = try? values.decodeIfPresent(UserGeoLocation.self, forKey: .geoLocation)
		} catch { print("Failed to decode UserAddress from response") }
	}
}

extension UserAddress {
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try? container.encodeIfPresent(street, forKey: .street)
		try? container.encodeIfPresent(suite, forKey: .suite)
		try? container.encodeIfPresent(city, forKey: .city)
		try? container.encodeIfPresent(zipcode, forKey: .zipcode)
		try? container.encodeIfPresent(geoLocation, forKey: .geoLocation)
	}
}
