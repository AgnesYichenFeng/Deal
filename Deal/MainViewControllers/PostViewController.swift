//
//  PostViewController.swift
//  Deal
//
//  Created by Nina Xie on 4/26/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import UIKit
import GoogleSignIn
//F changed
class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    
    var productNameTextField: UITextField!
    var priceTextField: UITextField!
    var descriptionTextView: UITextView!
    var postItemButton: UIButton!
    var photoPickerButton: UIButton!
    var photoPickerButton2: UIButton!
    var photoPickerButton3: UIButton!
    var photoPickerButton4: UIButton!
    var photoPickerButton5: UIButton!
    var photoPickerButton6: UIButton!
    
    let padding: CGFloat = 24
    let radius: CGFloat = 8
    let lightGrey = UIColor(named: "LightGrey")
    let red = UIColor(named: "Red")
    
    
    //    weak var delegate: postNewItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Post"
        view.backgroundColor = lightGrey
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Cross"), style: .plain, target: self, action: #selector(dismissViewController))
        
        
        
        productNameTextField = UITextField()
        productNameTextField.translatesAutoresizingMaskIntoConstraints = false
        productNameTextField.placeholder = "Name/Short summary of your item"
        productNameTextField.allowsEditingTextAttributes = true
        productNameTextField.borderStyle = .roundedRect
        productNameTextField.font = UIFont.systemFont(ofSize: 16)
        
        productNameTextField.layer.shadowColor = UIColor.lightGray.cgColor
        productNameTextField.layer.shadowOffset = CGSize(width: 1.5,height: 1.5)
        productNameTextField.layer.shadowRadius = 2
        productNameTextField.layer.shadowOpacity = 0.8
        view.addSubview(productNameTextField)
        
        
        priceTextField = UITextField()
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.placeholder = "Price of your item"
        priceTextField.allowsEditingTextAttributes = true
        priceTextField.borderStyle = .roundedRect
        priceTextField.font = UIFont.systemFont(ofSize: 16)
        priceTextField.keyboardType = .decimalPad
        
        priceTextField.layer.shadowColor = UIColor.lightGray.cgColor
        priceTextField.layer.shadowOffset = CGSize(width: 1.5,height: 1.5)
        priceTextField.layer.shadowRadius = 2
        priceTextField.layer.shadowOpacity = 0.8
        view.addSubview(priceTextField)
        
        
        descriptionTextView = UITextView()
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.text = "Tell us something about your item..."
        descriptionTextView.allowsEditingTextAttributes = true
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.textColor = .lightGray
        descriptionTextView.delegate = self
        
        descriptionTextView.layer.cornerRadius = radius
        descriptionTextView.layer.shadowColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.shadowOffset = CGSize(width: 1.5,height: 1.5)
        descriptionTextView.layer.shadowRadius = 2
        descriptionTextView.layer.shadowOpacity = 0.8
        descriptionTextView.layer.masksToBounds = false
        view.addSubview(descriptionTextView)
        
        
        photoPickerButton = UIButton()
        photoPickerButton.translatesAutoresizingMaskIntoConstraints = false
        photoPickerButton.layer.cornerRadius = radius
        photoPickerButton.layer.shadowColor = UIColor.lightGray.cgColor
        photoPickerButton.layer.shadowOffset = CGSize(width: 1.5,height: 1.5)
        photoPickerButton.layer.shadowRadius = 2
        photoPickerButton.layer.shadowOpacity = 0.8
        
        photoPickerButton.setImage(UIImage(named: "Upload"), for: .normal)
        photoPickerButton.addTarget(self, action: #selector(showImagePickerController), for: .touchUpInside)
        view.addSubview(photoPickerButton)
        
        photoPickerButton2 = UIButton()
        photoPickerButton2.translatesAutoresizingMaskIntoConstraints = false
        photoPickerButton2.layer.cornerRadius = radius
        photoPickerButton2.layer.shadowColor = UIColor.lightGray.cgColor
        photoPickerButton2.layer.shadowOffset = CGSize(width: 1.5,height: 1.5)
        photoPickerButton2.layer.shadowRadius = 2
        photoPickerButton2.layer.shadowOpacity = 0.8
        
        photoPickerButton2.setImage(UIImage(named: "Upload"), for: .normal)
        photoPickerButton2.addTarget(self, action: #selector(showImagePickerController), for: .touchUpInside)
        view.addSubview(photoPickerButton2)
        
        photoPickerButton3 = UIButton()
        photoPickerButton3.translatesAutoresizingMaskIntoConstraints = false
        photoPickerButton3.layer.cornerRadius = radius
        photoPickerButton3.layer.shadowColor = UIColor.lightGray.cgColor
        photoPickerButton3.layer.shadowOffset = CGSize(width: 1.5,height: 1.5)
        photoPickerButton3.layer.shadowRadius = 2
        photoPickerButton3.layer.shadowOpacity = 0.8
        
        photoPickerButton3.setImage(UIImage(named: "Upload"), for: .normal)
        photoPickerButton3.addTarget(self, action: #selector(showImagePickerController), for: .touchUpInside)
        view.addSubview(photoPickerButton3)
        
        photoPickerButton4 = UIButton()
        photoPickerButton4.translatesAutoresizingMaskIntoConstraints = false
        photoPickerButton4.layer.cornerRadius = radius
        photoPickerButton4.layer.shadowColor = UIColor.lightGray.cgColor
        photoPickerButton4.layer.shadowOffset = CGSize(width: 1.5,height: 1.5)
        photoPickerButton4.layer.shadowRadius = 2
        photoPickerButton4.layer.shadowOpacity = 0.8
        
        photoPickerButton4.setImage(UIImage(named: "Upload"), for: .normal)
        photoPickerButton4.addTarget(self, action: #selector(showImagePickerController), for: .touchUpInside)
        view.addSubview(photoPickerButton4)
        
        photoPickerButton5 = UIButton()
        photoPickerButton5.translatesAutoresizingMaskIntoConstraints = false
        photoPickerButton5.layer.cornerRadius = radius
        photoPickerButton5.layer.shadowColor = UIColor.lightGray.cgColor
        photoPickerButton5.layer.shadowOffset = CGSize(width: 1.5,height: 1.5)
        photoPickerButton5.layer.shadowRadius = 2
        photoPickerButton5.layer.shadowOpacity = 0.8
        
        photoPickerButton5.setImage(UIImage(named: "Upload"), for: .normal)
        photoPickerButton5.addTarget(self, action: #selector(showImagePickerController), for: .touchUpInside)
        view.addSubview(photoPickerButton5)
        
        
        photoPickerButton6 = UIButton()
        photoPickerButton6.translatesAutoresizingMaskIntoConstraints = false
        photoPickerButton6.layer.cornerRadius = radius
        photoPickerButton6.layer.shadowColor = UIColor.lightGray.cgColor
        photoPickerButton6.layer.shadowOffset = CGSize(width: 1.5,height: 1.5)
        photoPickerButton6.layer.shadowRadius = 2
        photoPickerButton6.layer.shadowOpacity = 0.8
        
        photoPickerButton6.setImage(UIImage(named: "Upload"), for: .normal)
        photoPickerButton6.addTarget(self, action: #selector(showImagePickerController), for: .touchUpInside)
        view.addSubview(photoPickerButton6)
        
        
        
        
        postItemButton = UIButton()
        postItemButton.translatesAutoresizingMaskIntoConstraints = false
        postItemButton.setTitle("Post New Item", for: .normal)
        postItemButton.setTitleColor(.white, for: .normal)
        postItemButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        postItemButton.layer.backgroundColor = red?.cgColor
        postItemButton.layer.cornerRadius = radius
        postItemButton.layer.shadowColor = UIColor.lightGray.cgColor
        postItemButton.layer.shadowOffset = CGSize(width: 2.5,height: 2.5)
        postItemButton.layer.shadowRadius = 5
        postItemButton.layer.shadowOpacity = 0.8
        postItemButton.addTarget(self, action: #selector(postItemToOnSaleAndDismiss), for: .touchUpInside)
        view.addSubview(postItemButton)
        
        self.hideKeyboardWhenTappedAround()
        
        setUpConstraints()
    }
    
    func setUpConstraints(){
        
        let photoLength: CGFloat = (self.view.frame.width-padding*4)/3
        
        NSLayoutConstraint.activate([
            productNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            productNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            productNameTextField.heightAnchor.constraint(equalToConstant: 60),
            productNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        
        NSLayoutConstraint.activate([
            priceTextField.topAnchor.constraint(equalTo: productNameTextField.bottomAnchor, constant: padding),
            priceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            priceTextField.heightAnchor.constraint(equalToConstant: 60),
            priceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: padding),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 180),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        
        NSLayoutConstraint.activate([
            photoPickerButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: padding),
            photoPickerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            photoPickerButton.heightAnchor.constraint(equalToConstant: photoLength),
            photoPickerButton.widthAnchor.constraint(equalToConstant: photoLength)
            ])
        
        NSLayoutConstraint.activate([
            photoPickerButton2.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: padding),
            photoPickerButton2.leadingAnchor.constraint(equalTo: photoPickerButton.trailingAnchor, constant: padding),
            photoPickerButton2.heightAnchor.constraint(equalToConstant: photoLength),
            photoPickerButton2.widthAnchor.constraint(equalToConstant: photoLength)
            ])
        
        NSLayoutConstraint.activate([
            photoPickerButton3.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: padding),
            photoPickerButton3.leadingAnchor.constraint(equalTo: photoPickerButton2.trailingAnchor, constant: padding),
            photoPickerButton3.heightAnchor.constraint(equalToConstant: photoLength),
            photoPickerButton3.widthAnchor.constraint(equalToConstant: photoLength)
            ])
        
        NSLayoutConstraint.activate([
            photoPickerButton4.topAnchor.constraint(equalTo: photoPickerButton.bottomAnchor, constant: padding),
            photoPickerButton4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            photoPickerButton4.heightAnchor.constraint(equalToConstant: photoLength),
            photoPickerButton4.widthAnchor.constraint(equalToConstant: photoLength)
            ])
        
        NSLayoutConstraint.activate([
            photoPickerButton5.topAnchor.constraint(equalTo: photoPickerButton.bottomAnchor, constant: padding),
            photoPickerButton5.leadingAnchor.constraint(equalTo: photoPickerButton4.trailingAnchor, constant: padding),
            photoPickerButton5.heightAnchor.constraint(equalToConstant: photoLength),
            photoPickerButton5.widthAnchor.constraint(equalToConstant: photoLength)
            ])
        
        NSLayoutConstraint.activate([
            photoPickerButton6.topAnchor.constraint(equalTo: photoPickerButton.bottomAnchor, constant: padding),
            photoPickerButton6.leadingAnchor.constraint(equalTo: photoPickerButton5.trailingAnchor, constant: padding),
            photoPickerButton6.heightAnchor.constraint(equalToConstant: photoLength),
            photoPickerButton6.widthAnchor.constraint(equalToConstant: photoLength)
            ])
        
        NSLayoutConstraint.activate([
            postItemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            postItemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postItemButton.widthAnchor.constraint(equalToConstant: view.frame.width-2*padding),
            postItemButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.descriptionTextView.textColor = .black
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
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
        photoPickerButton.contentMode = .scaleAspectFill
        photoPickerButton.setImage(pickedImage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @objc func postItemToOnSaleAndDismiss() {
        
        if let nameText = productNameTextField.text, !nameText.trimmingCharacters(in: .whitespaces).isEmpty {
            if let priceText = priceTextField.text, !priceText.trimmingCharacters(in: .whitespaces).isEmpty {
                if let descriptionText = descriptionTextView.text, !descriptionText.trimmingCharacters(in: .whitespaces).isEmpty {
                    
                    let googleID = (GIDSignIn.sharedInstance()?.currentUser.authentication.idToken)!
                    let newName = productNameTextField.text
                    let newPrice = NumberFormatter().number(from: priceTextField.text!)!.doubleValue
                    let newUserName = GIDSignIn.sharedInstance()?.currentUser.profile.givenName
                    let newDescription = descriptionTextView.text
                    //TODO: add array of images
                    
                    let itemImage1 = photoPickerButton.image(for: .normal)!.toBase64()
                    let itemImage2 = photoPickerButton2.image(for: .normal)!.toBase64()
                    let itemImage3 = photoPickerButton3.image(for: .normal)!.toBase64()
                    let itemImage4 = photoPickerButton4.image(for: .normal)!.toBase64()
                    let itemImage5 = photoPickerButton5.image(for: .normal)!.toBase64()
                    let itemImage6 = photoPickerButton6.image(for: .normal)!.toBase64()
                    
                    
                    let newPostItem = Item(userGoogleId: googleID, itemName: newName!, itemPrice: newPrice, userName: newUserName!, descriptionText: newDescription!, itemImage1: itemImage1!, itemImage2: itemImage2!, itemImage3: itemImage3!, itemImage4: itemImage4!, itemImage5: itemImage5!, itemImage6: itemImage6!, id: 0)
                    
                    // TODO: post Item ...
                    NetworkManager.postNewItem(item: newPostItem, googleID: googleID)
                    
                    return
                        
                    self.dismiss(animated: true, completion: nil)
                    
                }
            }
            //delegate?.addNewItem(newItem: newPostItem) // for testing
        }
        let alert = UIAlertController(title: "Invalid Item Infomation", message: "The Item Name or Price or Description is not valid.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
