//
//  MKMapView+Ext.swift
//  DemoProject
//
//  Created by Avinash Sharma on 16/01/23.
//

import Foundation
import MapKit

extension MKMapView {
	
	func fitAll() {
		var zoomRect = MKMapRect.null;
		for annotation in annotations {
			let annotationPoint = MKMapPoint(annotation.coordinate)
			let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
			zoomRect = zoomRect.union(pointRect);
		}
		setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
	}
}
