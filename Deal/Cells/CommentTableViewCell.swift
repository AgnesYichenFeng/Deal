//
//  CommentTableViewCell.swift
//  Deal
//
//  Created by Nina Xie on 4/30/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    var userNameLabel: UILabel!
    var messageLabel: UILabel!
    
    let padding1: CGFloat = 24
    let padding2: CGFloat = 12
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = .systemFont(ofSize: 18)
        userNameLabel.textColor = .darkGray
        contentView.addSubview(userNameLabel)
        
        messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = .systemFont(ofSize: 18)
        messageLabel.textColor = .black
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        contentView.addSubview(messageLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding2),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding1),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding1),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: padding2),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding1),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding1),
            ])
    }
    
    
    func configure(for comment: Comment) {
        userNameLabel.text = comment.userName
        messageLabel.text = comment.message
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
