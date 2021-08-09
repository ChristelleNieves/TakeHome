//
//  CampaignCell.swift
//  Takehome
//
//  Created by Christelle Nieves on 8/7/21.
//

import UIKit

class CampaignCell: UITableViewCell {
    
    var collectionView: UICollectionView!
    var medias: [Media]?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.10)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

extension CampaignCell {
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(MediaCell.self, forCellWithReuseIdentifier: "MediaCell")
        collectionView?.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView!)
        
        // Constraints
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - CollectionView Delegate

extension CampaignCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = medias?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCell
        
        guard let media = medias?[indexPath.row] else { return cell }
        let image = DataManager().getImageFromURL(urlString: media.cover_photo_url)
        let trackingLink = media.tracking_link
        let downloadLink = media.download_url
        
        cell.setupCell(photo: image, trackingLink: trackingLink, downloadLink: downloadLink)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width * 1/2.5, height: self.frame.height)
    }
}

// MARK: - Helper Functions

extension CampaignCell {
    func setupCell(mediasData: [Media]) {
        self.medias = mediasData
    }
}
