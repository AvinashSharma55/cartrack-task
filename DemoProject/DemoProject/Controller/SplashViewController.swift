//
//  SplashViewController.swift
//  DemoProject
//
//  Created by Avinash Sharma on 13/01/23.
//

import UIKit

final class SplashViewController: UIViewController {
	
	private var imageView : UIImageView!
	private var viewModel : SplashViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
		setUpView()
    }
	
	func setUpView() {
		
		view.backgroundColor = .white
		
		imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints  = false
		imageView.backgroundColor = .clear
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: "splashIcon")
		
		view.addSubview(imageView)
		
		imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
		imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
		
		createViewModel()
	}
	
	func createViewModel() {
		
		viewModel = SplashViewModel.init(onCheckCompletion: {
			[weak self] status in
			if status {
				self?.launchHomeViewController()
			}
			else {
				self?.launchLoginViewController()
			}
		})
	}
	

	
	func launchLoginViewController() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
			if #available(iOS 13.0, *) {
				HelperFunctions.getFirstSceneDelegate()?.loginUser()
			} else {
				HelperFunctions.getAppDelegate()?.loginUser()
			}
		})
	}
	
	func launchHomeViewController() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
			if #available(iOS 13.0, *) {
				HelperFunctions.getFirstSceneDelegate()?.takeUserToHome()
			} else {
				HelperFunctions.getAppDelegate()?.takeUserToHome()
			}
		})
	}
	
	
	
	

}
