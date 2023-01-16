//
//  UserAnnotation.swift
//  DemoProject
//
//  Created by Avinash Sharma on 16/01/23.
//

import Foundation
import MapKit
import Contacts

class UserAnnotation : NSObject , MKAnnotation {
	let title : String?
	let coordinate: CLLocationCoordinate2D
	let userName : String?
	let subtitle: String?
	let address : UserAddress?
	var mapItem : MKMapItem? {
		if let userAddress = address {
			let addressDict = [CNPostalAddressCityKey : userAddress.city]
			let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict as [String : Any])
			let mapItem = MKMapItem(placemark: placemark)
			mapItem.name = self.title
			return mapItem
		}
		return nil
	}

	init(name: String?, coordinate: CLLocationCoordinate2D , userName : String? , companyName : String? , address : UserAddress?) {
		self.title = name
		self.coordinate = coordinate
		self.userName = userName
		self.subtitle = companyName
		self.address = address
		super.init()
	}
	
	
	
}
