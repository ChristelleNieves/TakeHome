//
//  CampaignHeaderView.swift
//  Takehome
//
//  Created by Christelle Nieves on 8/7/21.
//

import UIKit

class CampaignHeaderView: UIView {
    
    var campaignData: Campaign?
    let campaignIcon = UIImageView()
    let titleLabel = UILabel()
    let payPerInstallLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

extension CampaignHeaderView {
    func setupCampaignIcon() {
        guard let imagURL = campaignData?.campaign_icon_url else {
            print("error with image")
            return }
        
        campaignIcon.image = DataManager().getImageFromURL(urlString: imagURL)
        campaignIcon.layer.cornerRadius = 18
        campaignIcon.clipsToBounds = true
        self.addSubview(campaignIcon)
        
        // Constraints
        campaignIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            campaignIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            campaignIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            campaignIcon.widthAnchor.constraint(equalToConstant: 65),
            campaignIcon.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func setupTitleLabel() {
        titleLabel.text = campaignData?.campaign_name ?? ""
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        titleLabel.textColor = UIColor.black
        self.addSubview(titleLabel)
        
        // Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: campaignIcon.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: campaignIcon.trailingAnchor, constant: 10)
        ])
    }
    
    func setupPayPerInstallLabel() {
        payPerInstallLabel.text = (campaignData?.pay_per_install ?? "N/A") + " per install"
        payPerInstallLabel.font = UIFont.systemFont(ofSize: 16)
        payPerInstallLabel.textColor = UIColor.systemGreen
        self.addSubview(payPerInstallLabel)
        
        // Constraints
        payPerInstallLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            payPerInstallLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            payPerInstallLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
}
