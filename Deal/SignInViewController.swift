//
//  AppDelegate.swift
//  Deal
//
//  Created by Nina Xie on 4/25/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import UIKit
import GoogleSignIn


class SignInViewController: UIViewController,  GIDSignInUIDelegate, GIDSignInDelegate{
    
    //    var appNameLabel: UILabel!
    //
    //    let verticalSpace: CGFloat = 125
    //    let appName = "Deal"
    let red = UIColor(named: "Red")
    // [START viewcontroller_vars]
    var signInButton: GIDSignInButton!
    var titleLabel: UILabel!
    var subLabel: UILabel!
    var loadingLabel: UILabel!
    // [END viewcontroller_vars]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = red
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance()?.signInSilently()
        
        
        signInButton = GIDSignInButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.layer.borderWidth = 5
        signInButton.layer.cornerRadius = 25
        signInButton.layer.masksToBounds = true
        signInButton.clipsToBounds = true
        signInButton.center = view.center
        signInButton.colorScheme = .light
        signInButton.contentMode = .scaleAspectFill
        
        signInButton.layer.shadowColor = UIColor.white.cgColor
        signInButton.layer.shadowOffset = CGSize(width: 6,height: 6)
        signInButton.layer.shadowRadius = 8
        signInButton.layer.shadowOpacity = 1.0
        view.addSubview(signInButton)
        
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Deal"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .italicSystemFont(ofSize: 120)
//        titleLabel.font = .systemFont(ofSize: 120)
        view.addSubview(titleLabel)
        
        
        subLabel = UILabel()
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.text = "created by Fx&Hz"
        subLabel.textColor = .white
        subLabel.textAlignment = .center
        subLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(subLabel)
        
        
        loadingLabel = UILabel()
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = .white
        loadingLabel.textAlignment = .center
        loadingLabel.font = UIFont.systemFont(ofSize: 22)
        loadingLabel.isHidden = true
        view.addSubview(loadingLabel)
        
        
        setupConstraints()
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.receiveToggleAuthUINotification(_:)), name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
        //
        //        toggleAuthUI()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.widthAnchor.constraint(equalToConstant: 120)
            ])
        
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -65),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            loadingLabel.topAnchor.constraint(equalTo: signInButton.topAnchor),
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
    
    var error: NSError?
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error != nil) {
            print("\(error.localizedDescription)")
            return
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            signInButton.isHidden = true
            loadingLabel.isHidden = false
            
            
            let userName = user.profile.givenName
            let profileImage = UIImage(named: "UserProfile")?.ConvertImageToString()
            let googleId = user.authentication.idToken

            let newUser = User(googleID: googleId!, userName: user.profile.givenName, profileImage: profileImage!, personalInformation: "Tell us more about you... \nLeave Your contact information")
            
            NetworkManager.signInNewUser(googleID: googleId!, userName: userName!, info: "Tell us more")
            
            
            // dont have to check is the user is in database
            
//            for user in allUsers {
//                if googleID == user.googleID {
//                    let tabBarView = UINavigationController(rootViewController: TabBarController())
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                        self.present(tabBarView, animated: true, completion: nil)
//                    }
//                }
//            }
            
            //UserViewController().userNameLabel.text = user.profile.givenName
            //let givenName = user.profile.givenName!
            //User.currentUser = User(userName: givenName)
            
            let tabBarView = UINavigationController(rootViewController: TabBarController())
   
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.present(tabBarView, animated: true, completion: nil)
            }
        }
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIImage {
    func ConvertImageToString() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}

