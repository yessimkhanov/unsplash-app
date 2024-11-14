//
//  CollectionViewCell.swift
//  unsplash
//
//  Created by Nursultan Turekulov on 10.11.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    private let imageView: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           return imageView
       }()
    override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
        }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    func configureCell(_ image: UIImage){
        imageView.image = image
    }
}
