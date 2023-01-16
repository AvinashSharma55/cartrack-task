//
//  UserCompany.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//

import Foundation


struct UserCompany : Codable {
	
	var name : String?
	var catchPhrase : String?
	var bs : String?
	
	enum CodingKeys: String, CodingKey {
		case name
		case catchPhrase
		case bs
	}
}

extension UserCompany {
	init(from decoder : Decoder) throws {
		do{
			let values = try decoder.container(keyedBy: CodingKeys.self)
			name = try? values.decodeIfPresent(String.self, forKey: .name)
			catchPhrase = try? values.decodeIfPresent(String.self, forKey: .catchPhrase)
			bs = try? values.decodeIfPresent(String.self, forKey: .bs)
		} catch { print("Failed to decode UserCompany from response") }
	}
}

extension UserCompany {
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try? container.encodeIfPresent(name, forKey: .name)
		try? container.encodeIfPresent(catchPhrase, forKey: .catchPhrase)
		try? container.encodeIfPresent(bs, forKey: .bs)
	}
}

