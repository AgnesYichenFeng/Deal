//
//  ItemCollectionViewCell.swift
//  Deal
//
//  Created by Nina Xie on 4/26/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    var itemImage: UIImageView!
    var nameLabel: UILabel!
    var priceLabel: UILabel!
    var userLabel: UILabel!
    
    let imageHeight: CGFloat = 180
    let padding1: CGFloat = 18
    let padding2: CGFloat = 8
    let radius: CGFloat = 8
    let red = UIColor(named: "Red")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        itemImage = UIImageView(frame: .zero)
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemImage.contentMode = .scaleAspectFit
        contentView.addSubview(itemImage)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        contentView.addSubview(nameLabel)
        
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 18)
        priceLabel.textColor = red
        contentView.addSubview(priceLabel)
        
        userLabel = UILabel()
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.font = UIFont.systemFont(ofSize: 16)
        userLabel.textColor = .darkGray
        contentView.addSubview(userLabel)
        
        contentView.layer.cornerRadius = radius
        contentView.layer.masksToBounds = true
        
        setupConstrainst()
    }
    
    func setupConstrainst() {
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: imageHeight)
            ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding1),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1*padding1),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding1),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1*padding1),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            ])
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding1),
            userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1*padding1),
            userLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
    }
    
    func configure(for item: Item) {
        itemImage.image = convertBase64ToImage(imageString: item.itemImage1)
        nameLabel.text = item.itemName
        priceLabel.text = "$ \(item.itemPrice)"
        userLabel.text = item.userName
    }
    
    //Helper: Sring to Image
    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


