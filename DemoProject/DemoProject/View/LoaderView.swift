//
//  LoaderView.swift
//  DemoProject
//
//  Created by Avinash Sharma on 16/01/23.
//

import Foundation
import UIKit

class LoaderView {
	
	private var container: UIView = UIView()
	private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
	private var centreStackView = UIStackView()
	private var errorLabel = UILabel()
	private var errorImageView = UIImageView()
	private var actionButton = UIButton()
	var onActionButton : (()->())?
   
	
	func showActivityIndicator(uiView: UIView) {
	
		container.translatesAutoresizingMaskIntoConstraints = false
		container.backgroundColor =  HelperFunctions.getBlackColor(alpha: 0.5)
		
		uiView.addSubview(container)
	   
		container.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 0.0).isActive = true
		container.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: 0.0).isActive = true
		container.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 0.0).isActive = true
		container.bottomAnchor.constraint(equalTo: uiView.bottomAnchor, constant: 0.0).isActive = true
		
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		if #available(iOS 13.0, *) {
			activityIndicator.style = .medium
		} else {
			activityIndicator.style = .gray
		}
		activityIndicator.color = .white
		
		container.addSubview(activityIndicator)
		
		activityIndicator.centerXAnchor.constraint(equalTo: container.safeAreaLayoutGuide.centerXAnchor, constant: 0.0).isActive = true
		activityIndicator.centerYAnchor.constraint(equalTo: container.safeAreaLayoutGuide.centerYAnchor, constant: 0.0).isActive = true
		
		activityIndicator.startAnimating()
		errorImageView.isHidden = true
		actionButton.isHidden = true
		errorLabel.isHidden = true
	}

	func hideActivityIndicator(uiView: UIView) {
		activityIndicator.stopAnimating()
		errorImageView.isHidden = true
		actionButton.isHidden = true
		errorLabel.isHidden = true
		container.removeFromSuperview()
	}
	
	func showErrorLabel(errorType : APIState , uiView : UIView , errorMessage : String? = nil) {
		
		container.translatesAutoresizingMaskIntoConstraints = false
		container.backgroundColor = HelperFunctions.getBlackColor()
		uiView.addSubview(container)
		
		container.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 0.0).isActive = true
		container.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: 0.0).isActive = true
		container.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 0.0).isActive = true
		container.bottomAnchor.constraint(equalTo: uiView.bottomAnchor, constant: 0.0).isActive = true
		
		
		centreStackView.translatesAutoresizingMaskIntoConstraints = false
		centreStackView.axis = .vertical
		centreStackView.alignment = .center
		centreStackView.distribution = .equalSpacing
		centreStackView.spacing = 16.0
		centreStackView.backgroundColor = .clear
		
		container.addSubview(centreStackView)
		
		centreStackView.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
		centreStackView.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive =  true
		centreStackView.centerYAnchor.constraint(equalTo: container.safeAreaLayoutGuide.centerYAnchor, constant: 0.0).isActive = true
		
		
		errorImageView.translatesAutoresizingMaskIntoConstraints  = false
		errorImageView.backgroundColor = .clear
		errorImageView.clipsToBounds = true
		errorImageView.contentMode = .scaleAspectFill
		errorImageView.tintColor = .white
		
		
		errorLabel.translatesAutoresizingMaskIntoConstraints = false
		errorLabel.textAlignment = .center
		errorLabel.textColor = .white
		errorLabel.numberOfLines = 0
		errorLabel.lineBreakMode = .byWordWrapping
		errorLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		
	   
		actionButton.translatesAutoresizingMaskIntoConstraints = false
		actionButton.backgroundColor = .white
		actionButton.setTitle(StringConstants.loaderActionButtonTitle, for: .normal)
		actionButton.setTitleColor(.black, for: .normal)
		actionButton.layer.cornerRadius = 25.0
		actionButton.clipsToBounds = true
		actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
		
		actionButton.sizeToFit()

		if errorType == .network {
			errorLabel.text = StringConstants.networkErrorMessage
			errorImageView.image = UIImage(named : "networkError")
		}
		else if errorType == .server {
			if let errorMsg = errorMessage {
				errorLabel.text = errorMsg
			}
			else {
				errorLabel.text = StringConstants.serverErrorMessage
			}
			errorImageView.image = UIImage(named : "serverError")
		}
		
		
		centreStackView.addArrangedSubview(errorImageView)
		centreStackView.addArrangedSubview(errorLabel)
		centreStackView.addArrangedSubview(actionButton)
		
		
		actionButton.centerXAnchor.constraint(equalTo: centreStackView.safeAreaLayoutGuide.centerXAnchor, constant: 0.0).isActive = true
		actionButton.widthAnchor.constraint(equalToConstant: actionButton.frame.width + 76.0).isActive = true
		actionButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		
		errorLabel.leadingAnchor.constraint(equalTo: centreStackView.safeAreaLayoutGuide.leadingAnchor, constant: 16.0).isActive = true
		errorLabel.trailingAnchor.constraint(equalTo: centreStackView.safeAreaLayoutGuide.trailingAnchor, constant: -16.0).isActive = true
		
		errorImageView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
		errorImageView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
		
		errorImageView.isHidden = false
		actionButton.isHidden = false
		errorLabel.isHidden = false
		
	}
	
	func hideErrorView(uiView : UIView) {
		container.removeFromSuperview()
		centreStackView.removeFromSuperview()
		errorImageView.removeFromSuperview()
		actionButton.removeFromSuperview()
		errorImageView.isHidden = true
		actionButton.isHidden = true
		errorLabel.isHidden = true
	}
	
	@objc func actionButtonTapped(){
		self.onActionButton?()
	}
	
}
