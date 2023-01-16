//
//  UserMarkerAnnotationView.swift
//  DemoProject
//
//  Created by Avinash Sharma on 16/01/23.
//

import UIKit
import MapKit

class UserMarkerAnnotationView: MKMarkerAnnotationView {
	
	
	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		setUpView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func prepareForReuse() {
		glyphText = nil
		annotation = nil
	}
	
	func setUpView() {
		canShowCallout = true
		calloutOffset = CGPoint(x: -8, y: -8)
		markerTintColor = HelperFunctions.getBlackColor(alpha: 0.63)
		
		let rightAccessoryButton = UIButton(type: .detailDisclosure)
		rightAccessoryButton.setImage(UIImage(named: "navigationIcon"), for: .normal)
		rightAccessoryButton.tintColor = HelperFunctions.getBlackColor()
		
		rightCalloutAccessoryView = rightAccessoryButton
	}
	func setUpAnnotationView(annotation : UserAnnotation?) {
		guard let userAnnotation =  annotation else { return }
		self.annotation = userAnnotation
		if let letter = userAnnotation.userName?.first {
		  glyphText = String(letter)
		}
	}

}
