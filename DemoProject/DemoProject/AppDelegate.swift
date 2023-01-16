//
//  AppDelegate.swift
//  DemoProject
//
//  Created by Avinash Sharma on 13/01/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		if #available(iOS 13.0, *) {
		}
		else {
			window = UIWindow(frame: UIScreen.main.bounds)
			window?.rootViewController = SplashViewController()
			window?.makeKeyAndVisible()
			
		}
		return true
	}

	// MARK: UISceneSession Lifecycle

	@available(iOS 13.0, *)
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	@available(iOS 13.0, *)
	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
	}
	
	func loginUser() {
		let loginViewController = LoginViewController()
		window?.rootViewController = loginViewController
		window?.makeKeyAndVisible()
	}
	
	func takeUserToHome() {
		let homeViewController = HomeViewController()
		window?.rootViewController = homeViewController
		window?.makeKeyAndVisible()
	}


}

