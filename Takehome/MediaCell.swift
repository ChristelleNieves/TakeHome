//
//  MediaCell.swift
//  Takehome
//
//  Created by Christelle Nieves on 8/7/21.
//

import UIKit

class MediaCell: UICollectionViewCell {
    
    static var reuseIdentifier = "MediaCell"
    
    var coverPhoto = UIImageView()
    var copyLinkButton = UIButton()
    var downloadButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCoverPhoto()
        setupCopyLinkButton()
        setupDownloadButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

extension MediaCell {
    func setupCoverPhoto() {
        coverPhoto.layer.cornerRadius = 18
        coverPhoto.clipsToBounds = true
        contentView.addSubview(coverPhoto)
        
        // Constraints
        coverPhoto.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coverPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            coverPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            coverPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            coverPhoto.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.80)
        ])
    }
    
    func setupCopyLinkButton() {
        copyLinkButton.setImage(UIImage(systemName: "link"), for: .normal)
        copyLinkButton.imageView?.tintColor = UIColor.lightGray
        copyLinkButton.imageView?.contentMode = .scaleAspectFit
        copyLinkButton.backgroundColor = UIColor.white
        copyLinkButton.layer.cornerRadius = 12
        contentView.addSubview(copyLinkButton)
        
        // Constraints
        copyLinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            copyLinkButton.topAnchor.constraint(equalTo: coverPhoto.bottomAnchor, constant: 5),
            copyLinkButton.leadingAnchor.constraint(equalTo: coverPhoto.leadingAnchor, constant: 15),
            copyLinkButton.widthAnchor.constraint(equalTo: coverPhoto.widthAnchor, multiplier: 0.40),
            copyLinkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func setupDownloadButton() {
        downloadButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        downloadButton.imageView?.tintColor = UIColor.lightGray
        downloadButton.imageView?.contentMode = .scaleAspectFit
        downloadButton.backgroundColor = UIColor.white
        downloadButton.layer.cornerRadius = 12
        contentView.addSubview(downloadButton)
        
        // Constraints
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            downloadButton.topAnchor.constraint(equalTo: copyLinkButton.topAnchor),
            downloadButton.leadingAnchor.constraint(equalTo: copyLinkButton.trailingAnchor, constant: 5),
            downloadButton.widthAnchor.constraint(equalTo: copyLinkButton.widthAnchor),
            downloadButton.bottomAnchor.constraint(equalTo: copyLinkButton.bottomAnchor)
        ])
    }
}

// MARK: - Helper Functions

extension MediaCell {
    func setupCell(photo: UIImage, trackingLink: String, downloadLink: String) {
        
        // Set image
        coverPhoto.image = photo
        
        // Set link for copy button
        // Add action
        copyLinkButton.addAction(UIAction { action in
            // Copy the link to the user's clipboard
            UIPasteboard.general.string = trackingLink
        }, for: .touchUpInside)
        
        // Set link for download button
        // Add action
        downloadButton.addAction(UIAction { action in
            // Download photo/video to device
            DataManager().downloadFile(fileURLString: downloadLink)
        }, for: .touchUpInside)
    }
}
