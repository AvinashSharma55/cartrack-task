//
//  ViewController.swift
//  DemoProject
//
//  Created by Avinash Sharma on 13/01/23.
//

import UIKit

class LoginViewController : UIViewController {
	
	var signInLabel : UILabel!
	var loginButton : UIButton!
	var userNameContainerView : UIView!
	var userNameTextField : UITextField!
	var countryflagLabel : UILabel!
	var countrySelectionButton : UIButton!
	var passwordContainerView : UIView!
	var passwordTextField : UITextField!
	var passwordRevealButton : UIButton!
	var userNameErrorLabel : UILabel!
	var passwordErrorLabel : UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		setUpView()
		
	}
	
	func setUpView() {
		
		view.backgroundColor = HelperFunctions.getLoginViewBGColor()
		
		signInLabel = UILabel()
		signInLabel.translatesAutoresizingMaskIntoConstraints = false
		signInLabel.backgroundColor = .clear
		signInLabel.textColor = .white
		signInLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
		signInLabel.text = StringConstants.signInTitle
		signInLabel.textAlignment = .left
		signInLabel.numberOfLines = 1
		signInLabel.lineBreakMode = .byTruncatingTail
		
		view.addSubview(signInLabel)
		
		userNameContainerView = UIView()
		userNameContainerView.translatesAutoresizingMaskIntoConstraints = false
		userNameContainerView.backgroundColor = HelperFunctions.getLoginContainerViewsBGColor()
		userNameContainerView.layer.masksToBounds = true
		userNameContainerView.layer.cornerRadius = 18.0
		userNameContainerView.layer.borderWidth = 1.0
		userNameContainerView.layer.borderColor = HelperFunctions.getLoginContainerViewsBorderColor().cgColor
		
		view.addSubview(userNameContainerView)
		
		userNameErrorLabel = UILabel()
		userNameErrorLabel.translatesAutoresizingMaskIntoConstraints = false
		userNameErrorLabel.backgroundColor = .clear
		userNameErrorLabel.textColor = HelperFunctions.getErrorColor()
		userNameErrorLabel.textAlignment = .left
		userNameErrorLabel.text = StringConstants.userNameErrorMessage
		userNameErrorLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
		userNameErrorLabel.isHidden = true
		userNameErrorLabel.numberOfLines = 1
		userNameErrorLabel.lineBreakMode = .byTruncatingTail
		

		
		view.addSubview(userNameErrorLabel)
		
		passwordContainerView = UIView()
		passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
		passwordContainerView.backgroundColor = HelperFunctions.getLoginContainerViewsBGColor()
		passwordContainerView.layer.masksToBounds = true
		passwordContainerView.layer.cornerRadius = 18.0
		passwordContainerView.layer.borderWidth = 1.0
		passwordContainerView.layer.borderColor = HelperFunctions.getLoginContainerViewsBorderColor().cgColor
		
		view.addSubview(passwordContainerView)
		
		passwordErrorLabel = UILabel()
		passwordErrorLabel.translatesAutoresizingMaskIntoConstraints = false
		passwordErrorLabel.backgroundColor = .clear
		passwordErrorLabel.textColor = HelperFunctions.getErrorColor()
		passwordErrorLabel.textAlignment = .left
		passwordErrorLabel.text = StringConstants.passwordErrorMessage
		passwordErrorLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
		passwordErrorLabel.isHidden = false
		passwordErrorLabel.numberOfLines = 1
		passwordErrorLabel.lineBreakMode = .byTruncatingTail
		
	
		
		view.addSubview(passwordErrorLabel)
		
		loginButton = UIButton()
		loginButton.translatesAutoresizingMaskIntoConstraints  = false
		loginButton.backgroundColor =  .white
		loginButton.setTitle(StringConstants.loginButtonTitle, for: .normal)
		loginButton.setTitleColor( .black, for: .normal)
		loginButton.contentVerticalAlignment = .center
		loginButton.contentHorizontalAlignment = .center
		loginButton.layer.masksToBounds = true
		loginButton.layer.cornerRadius = 12.0
		loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21.0)
		loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)

		view.addSubview(loginButton)
		
		signInLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19.0).isActive = true
		signInLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -19.0).isActive = true
		signInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44.0).isActive = true
		
		userNameContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19.0).isActive = true
		userNameContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -19.0).isActive = true
		userNameContainerView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 19.0).isActive = true
		userNameContainerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
		
		userNameErrorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0).isActive = true
		userNameErrorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -19.0).isActive = true
		userNameErrorLabel.topAnchor.constraint(equalTo: userNameContainerView.bottomAnchor, constant: 2.0).isActive = true
		
		passwordContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19.0).isActive = true
		passwordContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -19.0).isActive = true
		passwordContainerView.topAnchor.constraint(equalTo: userNameErrorLabel.bottomAnchor, constant: 8.0).isActive = true
		passwordContainerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
		
		
		passwordErrorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0).isActive = true
		passwordErrorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -19.0).isActive = true
		passwordErrorLabel.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: 8.0).isActive = true
		
		loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19.0).isActive = true
		loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -19.0).isActive = true
		loginButton.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 19.0).isActive = true
		loginButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		
		setUpUserNameContainerView()
	}
	
	func setUpUserNameContainerView() {
		
		countryflagLabel = UILabel()
		countryflagLabel.translatesAutoresizingMaskIntoConstraints = false
		countryflagLabel.backgroundColor = .clear
		countryflagLabel.textAlignment = .center
		countryflagLabel.font = UIFont.systemFont(ofSize: 19.0, weight: .regular)
		countryflagLabel.textColor = .white
		countryflagLabel.text = "🇧🇪"
		
		userNameContainerView.addSubview(countryflagLabel)
		
		countrySelectionButton = UIButton()
		countrySelectionButton.translatesAutoresizingMaskIntoConstraints = false
		countrySelectionButton.backgroundColor  = .clear
		countrySelectionButton.setTitle(nil, for: .normal)
		countrySelectionButton.addTarget(self, action: #selector(countryButtonTapped(_:)), for: .touchUpInside)
		userNameContainerView.addSubview(countrySelectionButton)
		
		userNameTextField = UITextField()
		userNameTextField.translatesAutoresizingMaskIntoConstraints = false
		userNameTextField.backgroundColor = .clear
		userNameTextField.borderStyle = .none
		userNameTextField.font = UIFont.systemFont(ofSize: 19.0, weight: .regular)
		userNameTextField.delegate = self
		userNameTextField.returnKeyType = .next
		userNameTextField.keyboardType = .default
		userNameTextField.attributedPlaceholder = NSAttributedString.init(string: StringConstants.userNamePlaceholderTitle, attributes: [NSAttributedString.Key.foregroundColor : HelperFunctions.getLoginContainerViewsBorderColor() , NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0, weight: .regular)])
		userNameTextField.tag = 1
		userNameTextField.textColor  = .white
		userNameTextField.tintColor = .white
		userNameTextField.contentVerticalAlignment = .center
		
		
		userNameContainerView.addSubview(userNameTextField)
		
		countryflagLabel.leadingAnchor.constraint(equalTo: userNameContainerView.leadingAnchor, constant: 19.0).isActive = true
		countryflagLabel.centerYAnchor.constraint(equalTo: userNameContainerView.centerYAnchor, constant: 0.0).isActive = true
		countryflagLabel.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
		countryflagLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
		
		countrySelectionButton.leadingAnchor.constraint(equalTo: countryflagLabel.leadingAnchor, constant: 0.0).isActive = true
		countrySelectionButton.trailingAnchor.constraint(equalTo: countryflagLabel.trailingAnchor, constant: 0.0).isActive = true
		countrySelectionButton.topAnchor.constraint(equalTo: countryflagLabel.topAnchor, constant: 0.0).isActive = true
		countrySelectionButton.bottomAnchor.constraint(equalTo: countryflagLabel.bottomAnchor, constant: 0.0).isActive = true
		
		userNameTextField.leadingAnchor.constraint(equalTo: countryflagLabel.trailingAnchor, constant: 10.0).isActive =  true
		userNameTextField.trailingAnchor.constraint(equalTo: userNameContainerView.trailingAnchor, constant: 0.0).isActive = true
		userNameTextField.topAnchor.constraint(equalTo: userNameContainerView.topAnchor, constant: 0.0).isActive = true
		userNameTextField.bottomAnchor.constraint(equalTo: userNameContainerView.bottomAnchor, constant: 0.0).isActive = true
		
		setUpPasswordContainerView()
	}
	
	func setUpPasswordContainerView() {
		
		passwordTextField = UITextField()
		passwordTextField.translatesAutoresizingMaskIntoConstraints = false
		passwordTextField.backgroundColor = .clear
		passwordTextField.borderStyle = .none
		passwordTextField.font = UIFont.systemFont(ofSize: 19.0, weight: .regular)
		passwordTextField.delegate = self
		passwordTextField.returnKeyType = .done
		passwordTextField.keyboardType = .default
		passwordTextField.isSecureTextEntry = true
		passwordTextField.attributedPlaceholder = NSAttributedString.init(string: StringConstants.userPasswordPlaceholderTitle, attributes: [NSAttributedString.Key.foregroundColor : HelperFunctions.getLoginContainerViewsBorderColor() , NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0, weight: .regular)])
		passwordTextField.contentVerticalAlignment = .center
		passwordTextField.textColor = .white
		passwordTextField.tag = 2
		passwordTextField.tintColor = .white
		
		passwordContainerView.addSubview(passwordTextField)
		
		passwordRevealButton = UIButton()
		passwordRevealButton.translatesAutoresizingMaskIntoConstraints = false
		passwordRevealButton.backgroundColor = .clear
		passwordRevealButton.setImage(UIImage(named: "hidePassword"), for: .normal)
		passwordRevealButton.setImage(UIImage(named: "showPassword"), for: .selected)
		passwordRevealButton.addTarget(self, action: #selector(passwordRevealButtonTapped(_:)), for: .touchUpInside)
		passwordRevealButton.contentVerticalAlignment = .center
		passwordRevealButton.contentHorizontalAlignment = .center
		
		passwordContainerView.addSubview(passwordRevealButton)
		
		passwordTextField.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor, constant: 19.0).isActive = true
		passwordTextField.trailingAnchor.constraint(equalTo: passwordRevealButton.leadingAnchor, constant: -10.0).isActive = true
		passwordTextField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: 0.0).isActive = true
		passwordTextField.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: 0.0).isActive = true
		
		passwordRevealButton.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor, constant: -19.0).isActive = true
		passwordRevealButton.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: 0.0).isActive = true
		passwordRevealButton.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: 0.0).isActive = true
		passwordRevealButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
		
		
	}
	
	@objc func loginButtonTapped(_ sender : Any?) {
		guard let _ = sender else { return }
		
	}
	
	@objc func countryButtonTapped(_ sender : Any?) {
		
	}
	
	@objc func passwordRevealButtonTapped(_ sender : Any?) {
		guard let _ = sender else { return }
		passwordTextField.isSecureTextEntry.toggle()
		passwordRevealButton.isSelected = !passwordRevealButton.isSelected
	}


}

extension LoginViewController : UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField.tag == 1 {
			passwordTextField.becomeFirstResponder()
		}
		else {
			passwordTextField.resignFirstResponder()
		}
		return true
	}
}

