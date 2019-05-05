//
//  User.swift
//  Deal
//
//  Created by Feng Yichen on 2019/4/26.
//  Copyright © 2019 F(X). All rights reserved.
//

import Foundation
import UIKit

//profile image and user name from google account

// ************* Hard Code *************

//class User {
//    var userName: String
//    var profileImage: UIImage?
//    var personalInformation: String
////    TODO: var idToken: String  //type?
//
//    init(userName: String, profileImageName:String, personalInformation: String ){
//        self.userName = userName
//        profileImage = UIImage(named: profileImageName)
//        self.personalInformation = personalInformation
//    }
//}

// ************* Codable *************
struct UserResponse: Codable {
    var data: User
    var success: Bool
}

struct PostUserResponse: Codable {
    var success: Bool
}

struct User: Codable{
    var googleID: String
    var userName: String
    var profileImage: String
    var personalInformation: String
}
