//
//  CountryTableViewCell.swift
//  DemoProject
//
//  Created by Avinash Sharma on 15/01/23.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
	
	var countryFlagLabel : UILabel!
	var countryNameLabel : UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()

	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	required init?(coder: NSCoder) {
		   super.init(coder: coder)
	}
	   
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setUpContentView()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		countryFlagLabel.text = nil
		countryNameLabel.text = nil
	}
	
	func setUpContentView() {
		
		self.selectionStyle =  .none
		

		self.backgroundColor = HelperFunctions.getLoginContainerViewsBGColor()
	
		
		countryFlagLabel = UILabel()
		countryFlagLabel.translatesAutoresizingMaskIntoConstraints = false
		countryFlagLabel.backgroundColor = .clear
		countryFlagLabel.textColor = .white
		countryFlagLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		countryFlagLabel.textAlignment = .left
		countryFlagLabel.numberOfLines = 1
		countryFlagLabel.lineBreakMode = .byTruncatingTail
		
		
		contentView.addSubview(countryFlagLabel)
		
		countryNameLabel = UILabel()
		countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
		countryNameLabel.backgroundColor = .clear
		countryNameLabel.textColor = .white
		countryNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		countryNameLabel.textAlignment = .left
		countryNameLabel.numberOfLines = 1
		countryNameLabel.lineBreakMode = .byTruncatingTail
		
		contentView.addSubview(countryNameLabel)
		
		countryFlagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19.0).isActive = true
		countryFlagLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
		countryFlagLabel.trailingAnchor.constraint(equalTo: countryNameLabel.leadingAnchor, constant: -8.0).isActive = true
		countryFlagLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		
		countryNameLabel.leadingAnchor.constraint(equalTo: countryFlagLabel.trailingAnchor, constant: 8.0).isActive = true
		countryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19.0).isActive = true
		countryNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
		countryNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
		countryNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
	}
	
	func setUpCell(country : CountryModel? , selectedCountry : String?) {
		guard let countryModel = country else { return }
		countryFlagLabel.text = countryModel.flag ?? ""
		countryNameLabel.text = countryModel.name ?? ""
		if ((countryModel.name ?? "") == (selectedCountry ?? "")) {
			self.accessoryType = .checkmark
		}
		else {
			self.accessoryType = .none
		}
	}

}
