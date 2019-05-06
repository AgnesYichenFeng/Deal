//
//  ViewController.swift
//  Deal
//
//  Created by Nina Xie on 4/25/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import UIKit
import GoogleSignIn

//protocol UserLoggedIn: class {
//    func userNameAndPictureLoaded(name: String)
//}

class UserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var userImageViewButton: UIButton!
    var userNameLabel: UILabel!
    var userInformationTextView: UITextView!
    var onSaleButton: UIButton!
    var soldButton: UIButton!
    var favButton: UIButton!
    var boughtButton: UIButton!
    var signOutButton: UIButton!
    
    var redRec: UIView!
    var whiteRec: UIView!
    
    let padding: CGFloat = 18
    let radius: CGFloat = 8
    var buttonWidth: CGFloat!
    let lightGrey = UIColor(named: "LightGrey")
    let red = UIColor(named: "Red")
    var thisUserGoogleID: String? {
        return GIDSignIn.sharedInstance()?.currentUser.authentication.idToken
    }
    
    //  let userLoggedin = DealAPI.getUser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = lightGrey
        buttonWidth = (view.frame.width - padding*2)/4
        
        redRec = UIView()
        redRec.translatesAutoresizingMaskIntoConstraints = false
        redRec.backgroundColor = red
        redRec.layer.shadowColor = UIColor.lightGray.cgColor
        redRec.layer.shadowOffset = CGSize(width: 2.5,height: 2.5)
        redRec.layer.shadowRadius = 5
        redRec.layer.shadowOpacity = 0.8
        view.addSubview(redRec)
        
        userImageViewButton = UIButton()
        userImageViewButton.translatesAutoresizingMaskIntoConstraints = false
        userImageViewButton.setImage(UIImage(named: "UserProfile"), for: .normal)
        userImageViewButton.clipsToBounds = true
        userImageViewButton.contentMode = .scaleAspectFit
        userImageViewButton.addTarget(self, action: #selector(showImagePickerController), for: .touchUpInside)
        view.addSubview(userImageViewButton)
        
        userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        userNameLabel.numberOfLines = 1
        userNameLabel.textColor = .white
        userNameLabel.textAlignment = .left
        userNameLabel.text = GIDSignIn.sharedInstance()?.currentUser.profile.givenName!
        // userNameLabel.text = User.currentUser?.userName
        // userNameLabel.text = getUserName()
        
        view.addSubview(userNameLabel)
        
        userInformationTextView = UITextView()
        userInformationTextView.translatesAutoresizingMaskIntoConstraints = false
        userInformationTextView.text = "Tell us something about you... \nLeave your contact information"
        userInformationTextView.isEditable = true
        userInformationTextView.isScrollEnabled = true
        userInformationTextView.font = UIFont.systemFont(ofSize: 16)
        userInformationTextView.backgroundColor = .white
        userInformationTextView.textColor = .darkGray
        userInformationTextView.layer.cornerRadius = radius
        
        userInformationTextView.layer.shadowColor = UIColor.lightGray.cgColor
        userInformationTextView.layer.shadowOffset = CGSize(width: 2.5,height: 2.5)
        userInformationTextView.layer.shadowRadius = 5
        userInformationTextView.layer.shadowOpacity = 0.8
        userInformationTextView.layer.masksToBounds = false
        view.addSubview(userInformationTextView)
        
        whiteRec = UIView()
        whiteRec.translatesAutoresizingMaskIntoConstraints = false
        whiteRec.backgroundColor = .white
        whiteRec.layer.cornerRadius = radius
        whiteRec.layer.shadowColor = UIColor.lightGray.cgColor
        whiteRec.layer.shadowOffset = CGSize(width: 2.5,height: 2.5)
        whiteRec.layer.shadowRadius = 5
        whiteRec.layer.shadowOpacity = 0.8
        view.addSubview(whiteRec)
        
        onSaleButton = UIButton()
        onSaleButton.setTitle("On Sale", for: .normal)
        onSaleButton.setTitleColor(red, for: .normal)
        onSaleButton.translatesAutoresizingMaskIntoConstraints = false
        onSaleButton.addTarget(self, action: #selector(pushOnSaleItemsViewController), for: .touchUpInside)
        view.addSubview(onSaleButton)
        
        //        soldButton = UIButton()
        //        soldButton.setTitle("Sold", for: .normal)
        //        soldButton.setTitleColor(red, for: .normal)
        //        soldButton.translatesAutoresizingMaskIntoConstraints = false
        //        soldButton.addTarget(self, action: #selector(pushSoldItemsViewController), for: .touchUpInside)
        //        view.addSubview(soldButton)
        //
        favButton = UIButton()
        favButton.setTitle("Favorites", for: .normal)
        favButton.setTitleColor(red, for: .normal)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.addTarget(self, action: #selector(pushFavoriteItemsViewController), for: .touchUpInside)
        view.addSubview(favButton)
        
        //        boughtButton = UIButton()
        //        boughtButton.setTitle("Bought", for: .normal)
        //        boughtButton.setTitleColor(red, for: .normal)
        //        boughtButton.translatesAutoresizingMaskIntoConstraints = false
        //        boughtButton.addTarget(self, action: #selector(pushBoughtItemsViewController), for: .touchUpInside)
        //        view.addSubview(boughtButton)
        
        signOutButton = UIButton()
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.backgroundColor = red
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        signOutButton.addTarget(self, action: #selector(returnToSignInScreen), for: .touchUpInside)
        signOutButton.layer.cornerRadius = radius
        signOutButton.layer.shadowColor = UIColor.lightGray.cgColor
        signOutButton.layer.shadowOffset = CGSize(width: 2.5,height: 2.5)
        signOutButton.layer.shadowRadius = 5
        signOutButton.layer.shadowOpacity = 0.8
        view.addSubview(signOutButton)
        
        self.hideKeyboardWhenTappedAround()
        
        setupConstraints()
        //        setName()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            redRec.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            redRec.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            redRec.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            redRec.heightAnchor.constraint(equalToConstant:175)
            ])
        
        NSLayoutConstraint.activate([
            userImageViewButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            userImageViewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            userImageViewButton.heightAnchor.constraint(equalToConstant: 90),
            userImageViewButton.widthAnchor.constraint(equalToConstant: 90)
            ])
        
        NSLayoutConstraint.activate([
            userNameLabel.centerYAnchor.constraint(equalTo: userImageViewButton.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: userImageViewButton.trailingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1*padding)
            ])
        
        NSLayoutConstraint.activate([
            userInformationTextView.topAnchor.constraint(equalTo: userImageViewButton.bottomAnchor, constant: padding),
            userInformationTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            userInformationTextView.heightAnchor.constraint(equalToConstant: 180),
            userInformationTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        
        NSLayoutConstraint.activate([
            whiteRec.topAnchor.constraint(equalTo: userInformationTextView.bottomAnchor, constant: 2*padding),
            whiteRec.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            whiteRec.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            whiteRec.heightAnchor.constraint(equalToConstant: buttonWidth)
            ])
        
        NSLayoutConstraint.activate([
            favButton.topAnchor.constraint(equalTo: whiteRec.topAnchor),
            favButton.leadingAnchor.constraint(equalTo: whiteRec.leadingAnchor, constant: buttonWidth),
            favButton.heightAnchor.constraint(equalToConstant: buttonWidth),
            favButton.widthAnchor.constraint(equalToConstant: buttonWidth)
            ])
        
        
        //        NSLayoutConstraint.activate([
        //            boughtButton.topAnchor.constraint(equalTo: whiteRec.topAnchor),
        //            boughtButton.leadingAnchor.constraint(equalTo: favButton.trailingAnchor),
        //            boughtButton.heightAnchor.constraint(equalToConstant: buttonWidth),
        //            boughtButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        //            ])
        
        
        NSLayoutConstraint.activate([
            onSaleButton.topAnchor.constraint(equalTo: whiteRec.topAnchor),
            onSaleButton.leadingAnchor.constraint(equalTo: favButton.trailingAnchor),
            onSaleButton.heightAnchor.constraint(equalToConstant: buttonWidth),
            onSaleButton.widthAnchor.constraint(equalToConstant: buttonWidth)
            ])
        
        //        NSLayoutConstraint.activate([
        //            soldButton.topAnchor.constraint(equalTo: whiteRec.topAnchor),
        //            soldButton.leadingAnchor.constraint(equalTo: onSaleButton.trailingAnchor),
        //            soldButton.heightAnchor.constraint(equalToConstant: buttonWidth),
        //            soldButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        //            ])
        
        NSLayoutConstraint.activate([
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1*padding),
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            signOutButton.widthAnchor.constraint(equalToConstant: 150)
            ])
    }
    
    
    //    func getUserName() ->String {
    //
    //        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
    //            if let givenName = GIDSignIn.sharedInstance()?.currentUser.profile.givenName {
    //                return givenName}
    //        }
    //            return "Name"
    //    }
    
    
    @objc func showImagePickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage = info[.originalImage] as? UIImage
        userImageViewButton.contentMode = .scaleAspectFill
        userImageViewButton.setImage(pickedImage, for: .normal)
        dismiss(animated: true, completion: nil)
        
        let userInfo = userInformationTextView.text
        let imageString = userImageViewButton.image(for: .normal)?.imageToString()
        //TODO: save user description ...
        NetworkManager.updateUserInformation(info: userInfo ?? "I have nothing to say.", image: imageString!, googleID: thisUserGoogleID!) { (user) in
            
            // do something???
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        let userInfo = userInformationTextView.text
        let imageString = userImageViewButton.image(for: .normal)?.imageToString()
        //TODO: save user description ...
        NetworkManager.updateUserInformation(info: userInfo ?? "I have nothing to say.", image: imageString!, googleID: thisUserGoogleID!) { (user) in
            // do something???
        }
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func pushOnSaleItemsViewController(_ target: UIButton) {
        NetworkManager.getOneUserPosts(with: thisUserGoogleID!) { (onSaleItems) in
            let onSaleItemsViewController = ItemsOnProfileViewController(items: onSaleItems)
            
            onSaleItemsViewController.title = "On Sale"
            self.navigationController?.pushViewController(onSaleItemsViewController, animated: true)
            
            
            // Change title from being default back button text
            let backButton = UIBarButtonItem()
            backButton.title = "Back"
            self.navigationItem.backBarButtonItem = backButton
        }
        
        
    }
    
    
    
    @objc func pushFavoriteItemsViewController(_ target: UIButton) {
        
        NetworkManager.getOneUserFavs(with: thisUserGoogleID!) { (favItems) in
            let favoriteItemsViewController = ItemsOnProfileViewController(items: favItems)
            favoriteItemsViewController.title = "My Favorite"
            self.navigationController?.pushViewController(favoriteItemsViewController, animated: true)
            
            // Change title from being default back button text
            
            let backButton = UIBarButtonItem()
            backButton.title = "Back"
            self.navigationItem.backBarButtonItem = backButton
        }
        
    }
    
    func getThisUserAndReload(googleID: String) -> Void {
        NetworkManager.getOneUser(with: googleID) { (user) in
            let userImage = self.convertBase64ToImage(imageString: user.profileImage)
            DispatchQueue.main.async {
                self.userImageViewButton.setImage(userImage, for: .normal)
                self.userInformationTextView.text = user.personalInformation
            }
        }
    }
    
    
    
    
    @objc func returnToSignInScreen(_ target: UIButton){
        GIDSignIn.sharedInstance().signOut()
        self.present(SignInViewController(), animated: true, completion: nil)
    }
    
    //Helper: Sring to Image
    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
    
    //    @objc func pushSoldItemsViewController(_ target: UIButton) {
    //
    //        let soldItemsViewController = ItemsOnProfileViewController()
    //
    //        soldItemsViewController.title = "Sold"
    //        navigationController?.pushViewController(soldItemsViewController, animated: true)
    //
    //
    //        // Change title from being default back button text
    //        let backButton = UIBarButtonItem()
    //        backButton.title = "Back"
    //        navigationItem.backBarButtonItem = backButton
    //
    //    }
    //
    //    @objc func pushBoughtItemsViewController(_ target: UIButton) {
    //
    //        let boughtItemsViewController = ItemsOnProfileViewController()
    //
    //        boughtItemsViewController.title = "Bought"
    //        navigationController?.pushViewController(boughtItemsViewController, animated: true)
    //
    //
    //        // Change title from being default back button text
    //        let backButton = UIBarButtonItem()
    //        backButton.title = "Back"
    //        navigationItem.backBarButtonItem = backButton
    //
    //    }
    
    
    
    
}

extension UIImage {
    func imageToString() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}

//extension UserViewController: UserLoggedIn {
//    func userNameAndPictureLoaded(name: String) {
//        userNameLabel.text = name
//        //userImageViewButton.image = UIImage(named: imageName)
//    }
//}

