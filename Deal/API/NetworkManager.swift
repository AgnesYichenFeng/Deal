//
//  NetworkManager.swift
//  Deal
//
//  Created by Feng Yichen on 2019/5/3.
//  Copyright © 2019 F(X). All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let url = "http://35.185.8.240/"
    
    
    
    //***********************Post****************************
    
    
    //POST /api/user/
    static func signInNewUser (googleID: String, userName: String, info: String) -> Void  {
        let createNewUser = "\(NetworkManager.url)api/user/\(googleID)/"
        let parameters: Parameters = [
            //"googleID": user.googleID,
            "userName": userName,
            "personalInformation": info,
        ]
        Alamofire.request(createNewUser, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print(data)
                //                let jsonDecoder = JSONDecoder()
                //                if let postUserResponse = try? jsonDecoder.decode(PostUserResponse.self, from: data) {
                //                    completion(postUserResponse.success)
                //                } else {
                //                    print("Invalid Response Data")
            //                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
    //Update the information of a user
    //POST /api/user/update/<string:user_id>/
    static func updateUserInformation (info: String, image: String, googleID: String, completion: @escaping (Bool) -> Void) {
        let updateUser = "\(NetworkManager.url)api/user/update/\(googleID)/"
        let parameters: Parameters = [
            "personalInformation": info,
            "profileImage": image
        ]
        Alamofire.request(updateUser, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let postUserResponse = try? jsonDecoder.decode(PostUserResponse.self, from: data) {
                    completion(postUserResponse.success)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //POST /api/user/post/<string:googleID>/
    
    
    static func postNewItem (item: Item, googleID: String) -> Void {
        let createNewPost = "\(NetworkManager.url)api/user/post/\(googleID)/"
        let parameters: Parameters = [
            "itemName": item.itemName,
            "itemPrice": item.itemPrice,
            "descriptionText": item.descriptionText,
            "userName": item.userName,
            //"comments": [],
            //"userGoogleId": item.userGoogleId,
            "itemImage1": item.itemImage1,
            "itemImage2": item.itemImage2,
            "itemImage3": item.itemImage3,
            "itemImage4": item.itemImage4,
            "itemImage5": item.itemImage5,
            "itemImage6": item.itemImage6
        ]
        Alamofire.request(createNewPost, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print(data)
                //                let jsonDecoder = JSONDecoder()
                //                if let postItemResponse = try? jsonDecoder.decode(PostItemResponse.self, from: data) {
                //                    completion(postItemResponse.success)
                //                } else {
                //                    print("Invalid Response Data")
                //                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// /api/favouritePosts/<string:user_id>/<int:post_id>/
    // Add item to fav items
    static func addFavoriteItem(with postID: Int, with googleID: String, completion: @escaping (Bool) -> Void) {
        let addFav = "\(NetworkManager.url)api/favouritePosts/\(googleID)/\(postID)/"
        let parameters: Parameters = [
            "googleId": googleID,
            "id": postID
        ]
        Alamofire.request(addFav, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let postUserResponse = try? jsonDecoder.decode(PostUserResponse.self, from: data) {
                    completion(postUserResponse.success)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    //POST /api/post/post/<string:googleID>/<int:post_id>/comment/
    static func postNewComment(comment: Comment, with postID: Int, with googleID: String, completion: @escaping (Bool) -> Void) {
        let addComment = "\(NetworkManager.url)api/post/post/\(googleID)/\(postID)/comment/"
        let parameters: Parameters = [
            //"comment": comment,
            "message": comment.message,
            "user_id": googleID,
            "post_id": postID
        ]
        Alamofire.request(addComment, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let postCommentResponse = try? jsonDecoder.decode(PostCommentResponse.self, from: data) {
                    completion(postCommentResponse.success)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    //***********************************************************************
    //*******************Get************************
    //GET /api/users/
    static func getAllUsers (completion: @escaping([User]) -> Void){
        let allUsers = "\(NetworkManager.url)api/user/"
        Alamofire.request(allUsers, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let usersResponse = try? jsonDecoder.decode(UsersResponse.self, from: data) {
                    completion(usersResponse.data)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
    
    //GET /api/user/<string:googleID>/
    static func getOneUser (with googleID: String, completion: @escaping(User) -> Void){
        let oneUserData = "\(NetworkManager.url)api/user/\(googleID)/"
        Alamofire.request(oneUserData, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(UserResponse.self, from: data) {
                    completion(userResponse.data)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //GET one user's posts
    //  /api/posts/<string:user_id>/
    static func getOneUserPosts (with googleID: String, completion: @escaping([Item]) -> Void){
        let oneUserPosts = "\(NetworkManager.url)api/posts/\(googleID)/"
        Alamofire.request(oneUserPosts, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let getItemsResponse = try? jsonDecoder.decode(GetItemsResponse.self, from: data) {
                    completion(getItemsResponse.data)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    //Get one user's favorites
    //  /api/favouritePosts/<string:googleID>/
    static func getOneUserFavs (with googleID: String, completion: @escaping([Item]) -> Void){
        let getFavPosts = "\(NetworkManager.url)api/favouritePosts/\(googleID)/"
        Alamofire.request(getFavPosts, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let getItemsResponse = try? jsonDecoder.decode(GetItemsResponse.self, from: data) {
                    completion(getItemsResponse.data)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    //GET all posts
    //   /api/posts/
    static func getAllPosts(completion: @escaping([Item]) -> Void){
        let oneUserData = "\(NetworkManager.url)api/posts/"
        Alamofire.request(oneUserData, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let getItemsResponse = try? jsonDecoder.decode(GetItemsResponse.self, from: data) {
                    completion(getItemsResponse.data)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    // GET /api/post/<int:post_id>/comments/
    static func getAllComments (with postID: Int, completion: @escaping([Comment]) -> Void){
        let allComments = "\(NetworkManager.url)api/post/\(postID)/comments/"
        Alamofire.request(allComments, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let commentsResponse = try? jsonDecoder.decode(CommentsResponse.self, from: data) {
                    completion(commentsResponse.data)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    // DELETE /api/post/<int:post_id>/
    //delete a post
    static func deleteOnePost(id: Int) -> Void {
        let deletePost = "\(NetworkManager.url)api/post/\(id)/"
        Alamofire.request(deletePost, method: .delete)
    }
    
    
    
    
    
}


extension UIImage {
    func uiimageToString() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
