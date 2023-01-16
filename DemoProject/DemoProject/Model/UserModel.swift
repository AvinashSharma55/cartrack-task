//
//  UserModel.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//

import Foundation

struct UserModel : Codable {
	
	var id : Int?
	var name : String?
	var username : String?
	var email : String?
	var address : UserAddress?
	var phone : String?
	var website : String?
	var company : UserCompany?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case username
		case email
		case address
		case phone
		case website
		case company
	}
}

extension UserModel {
	init(from decoder : Decoder) throws {
		do{
			let values = try decoder.container(keyedBy: CodingKeys.self)
			id = try? values.decodeIfPresent(Int.self, forKey: .id)
			name = try? values.decodeIfPresent(String.self, forKey: .name)
			username = try? values.decodeIfPresent(String.self, forKey: .username)
			email = try? values.decodeIfPresent(String.self, forKey: .email)
			address = try? values.decodeIfPresent(UserAddress.self, forKey: .address)
			phone = try? values.decodeIfPresent(String.self, forKey: .phone)
			website = try? values.decodeIfPresent(String.self, forKey: .website)
			company = try? values.decodeIfPresent(UserCompany.self, forKey: .company)
		} catch { print("Failed to decode UserModel from response") }
	}
}

extension UserModel {
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try? container.encodeIfPresent(id, forKey: .id)
		try? container.encodeIfPresent(name, forKey: .name)
		try? container.encodeIfPresent(username, forKey: .username)
		try? container.encodeIfPresent(email, forKey: .email)
		try? container.encodeIfPresent(address, forKey: .address)
		try? container.encodeIfPresent(phone, forKey: .phone)
		try? container.encodeIfPresent(website, forKey: .website)
		try? container.encodeIfPresent(company, forKey: .company)
	}
}
