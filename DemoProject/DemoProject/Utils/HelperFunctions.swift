//
//  HelperFunctions.swift
//  DemoProject
//
//  Created by Avinash Sharma on 13/01/23.
//

import Foundation
import UIKit


class HelperFunctions {
	
	@available(iOS 13.0, *)
	class func getFirstSceneDelegate() -> SceneDelegate? {
		for scene in UIApplication.shared.connectedScenes {
			if let sceneDelagate = scene.delegate as? SceneDelegate {
				return sceneDelagate
			}
		}
		return nil
	}
	
	class func getAppDelegate() -> AppDelegate? {
		let appDelegate = UIApplication.shared.delegate as? AppDelegate
		return appDelegate
	}
	
	class func getColorFrom(red : CGFloat? , green : CGFloat? , blue : CGFloat? , alpha : CGFloat?) -> UIColor {
		let color = UIColor.init(red: ((red ?? 0)/255.0), green: ((green ?? 0)/255.0), blue: ((blue ?? 0)/255.0), alpha: alpha ?? 1.0)
		return color
	}
	
	class func getLoginViewBGColor() -> UIColor {
		return getColorFrom(red: 25, green: 23, blue: 32, alpha: 1.0)
	}
	
	class func getLoginContainerViewsBGColor() -> UIColor {
		return getColorFrom(red: 30, green: 28, blue: 36, alpha: 1.0)
	}
	
	class func getLoginContainerViewsBorderColor() -> UIColor {
		return self.getColorFrom(red: 112, green: 112, blue: 112, alpha: 1)
	}
	
	class func getErrorColor() -> UIColor {
		return self.getColorFrom(red: 255, green: 102, blue: 102, alpha: 1)
	}
	
	class func getBlackColor(alpha : CGFloat = 1) -> UIColor {
		return self.getColorFrom(red: 0, green: 0, blue: 0, alpha: alpha)
	}
	class func countryTopViewColor() -> UIColor {
		return self.getColorFrom(red: 139, green: 139, blue: 139, alpha: 1)
	}
	class func pickerTableViewCellBGColor() -> UIColor {
		return self.getColorFrom(red: 55, green: 57, blue: 59, alpha: 1)
	}
	
}
