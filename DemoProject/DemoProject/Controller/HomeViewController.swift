//
//  HomeViewController.swift
//  DemoProject
//
//  Created by Avinash Sharma on 14/01/23.
//

import UIKit
import MapKit

final class HomeViewController: BaseViewController {
	
	private var homeViewModel : HomeViewModel!
	private var mapView : MKMapView!
	private var dataSource : [UserAnnotation]?

    override func viewDidLoad() {
        super.viewDidLoad()
		setUpViewModel()
    }
	
	func setUpViewModel() {
		
		homeViewModel = HomeViewModel.init(loading: {
			[weak self] state in
			if state == .loading {
				self?.loaderView.showActivityIndicator(uiView: self?.view ?? UIView())
			}
			else {
				self?.loaderView.showErrorLabel(errorType: state, uiView: self?.view ?? UIView())
			}
		})
		homeViewModel.onSuccessfullyFetchingData = {
			[weak self] userAnnotation in
			self?.dataSource = userAnnotation
			self?.setUpMapView()
		}
		loaderView.onActionButton = {
			[weak self] in
			self?.homeViewModel.retryFetchingUsers()
		}
	}
	
	func setUpMapView() {
		
		mapView = MKMapView()
		mapView.translatesAutoresizingMaskIntoConstraints = false
		mapView.backgroundColor = .clear
		mapView.showsUserLocation = true
		mapView.delegate = self
		mapView.register(UserMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: UserMarkerAnnotationView.reuseIdentifier)
		view.addSubview(mapView)
		
		mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
		mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
		mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
		mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
		
		mapView.addAnnotations(self.dataSource ?? [])
		mapView.fitAll()
	}
	
}

extension HomeViewController : MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard let userAnnotation = annotation as? UserAnnotation else { return nil }
		let annotationMarkerView = mapView.dequeueReusableAnnotationView(withIdentifier: UserMarkerAnnotationView.reuseIdentifier, for: annotation) as? UserMarkerAnnotationView
		annotationMarkerView?.setUpAnnotationView(annotation: userAnnotation)
		return annotationMarkerView ?? nil
	}
	
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		guard let userAnnotation = view.annotation as? UserAnnotation else { return }
		let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
		userAnnotation.mapItem?.openInMaps(launchOptions: launchOptions)
	}
}
