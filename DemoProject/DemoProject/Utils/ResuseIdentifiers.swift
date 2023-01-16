//
//  UITableViewCell+Ext.swift
//  DemoProject
//
//  Created by Avinash Sharma on 15/01/23.
//

import Foundation
import  UIKit
import MapKit

protocol ReuseIdentifying {
	static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
	}
}

extension UITableViewCell : ReuseIdentifying {}
extension MKMarkerAnnotationView : ReuseIdentifying {}
