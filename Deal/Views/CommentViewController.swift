//
//  CommentViewController.swift
//  Deal
//
//  Created by Nina Xie on 4/30/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import UIKit
import GoogleSignIn

class CommentViewController: UIViewController, UITextFieldDelegate {
    var itemId: Int
    
    var commentTableView: UITableView!
    var commentTextField: UITextField!
    
    var commentTextFieldBottomAnchor: NSLayoutConstraint!
    var comments: [Comment]!
    let commentCellReuseIdentifier = "CommentCellReuseIdentifier"
    
    let padding: CGFloat = 24
    
    init(itemId: Int) {
        self.itemId = itemId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
//        comments = DealAPI.getComment()  // for testing
        getComments()
        
        commentTableView = UITableView()
        commentTableView.translatesAutoresizingMaskIntoConstraints = false
        commentTableView.dataSource = self
        commentTableView.delegate = self
        commentTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: commentCellReuseIdentifier)
        commentTableView.tableFooterView = UIView() // so there's no empty lines at the bottom
        
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.estimatedRowHeight = 96
        view.addSubview(commentTableView)
        
        
        commentTextField = UITextField()
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.placeholder = "Leave your comments"
        commentTextField.allowsEditingTextAttributes = true
        commentTextField.borderStyle = .roundedRect
        commentTextField.font = UIFont.systemFont(ofSize: 16)
        commentTextField.delegate = self
        
        commentTextField.layer.shadowColor = UIColor.lightGray.cgColor
        commentTextField.layer.shadowOffset = CGSize(width: 2.5 ,height: 2.5)
        commentTextField.layer.shadowRadius = 2.5
        commentTextField.layer.shadowOpacity = 0.8
        view.addSubview(commentTextField)
        
        
        commentTextFieldBottomAnchor = NSLayoutConstraint(item: commentTextField, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -padding)
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            commentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            commentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.5*padding),
            commentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1*padding),
            commentTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1*padding-60),
            ])
        
        NSLayoutConstraint.activate([
            commentTextFieldBottomAnchor,
            commentTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            commentTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1*padding),
            commentTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    func getComments() {
        NetworkManager.getAllComments(with: itemId) { (allComments) in
            self.comments = allComments
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        commentTextFieldBottomAnchor.constant = -padding-295
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        commentTextFieldBottomAnchor.constant = -padding
        
        if let message = textField.text, !message.trimmingCharacters(in: .whitespaces).isEmpty {
            let googleId = GIDSignIn.sharedInstance()?.currentUser.authentication.idToken
            let newComment = Comment(userName: (GIDSignIn.sharedInstance()?.currentUser.profile.givenName)!, message: message)
            
            //TODO: textField.text ... saved as comment message
            NetworkManager.postNewComment(comment: newComment, with: itemId, with: googleId!) { (success) in
                // do something?
            }
        }
        
        textField.text = nil
        
        return true
    }
    
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentCell = tableView.dequeueReusableCell(withIdentifier: commentCellReuseIdentifier, for: indexPath) as! CommentTableViewCell
        commentCell.configure(for: comments[indexPath.row])
        commentCell.selectionStyle = .none
        return commentCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
