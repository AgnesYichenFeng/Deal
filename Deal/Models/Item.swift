//
//  Item.swift
//  Deal
//
//  Created by Nina Xie on 4/26/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import UIKit
import Foundation

// ************* Hard Code *************
//class Item {
//    let userGoogleId: String
//    let itemName: String
//    let itemPrice: Double
//    let userName: String  // TODO: seller: User
//    let descriptionText: String
//    let imageSet: [UIImage]
//    var isLiked: Bool = false
//    var isBought: Bool = false
//    var isSold: Bool = false
//    var isCompleted: Bool = false
//
//    init (id: String, name: String, price: Double, user: String, description: String, images: [UIImage]) {
//        userGoogleId = id
//        itemName = name
//        itemPrice = price
//        userName = user
//        descriptionText = description
//        imageSet = images
//    }
//}

// ************* Codable *************

//struct ListOnProfile: Codable {
//    var lists: [ItemList]
//}
//
//struct ItemList: Codable {
//    var items: [Item]
//}
//
//struct FavoriteItemList: Codable {
//    var favoriteItems: [Item]
//}
//
//struct SoldItemList: Codable {
//    var soldItems: [Item]
//}
//
//struct OnSaleItemList: Codable {
//    var onSaleItems: [Item]
//}
//
//struct BoughtItemList: Codable {
//    var boughtItems: [Item]
//}


struct GetItemResponse: Codable {
    var data: Item
    var success: Bool
}

struct GetItemsResponse: Codable {
    var data: [Item]
    var success: Bool
}

struct PostItemResponse: Codable {
    var success: Bool
}

struct Item: Codable {
    var userGoogleId: String
    var itemName: String
    var itemPrice: Double
    var userName: String
    var descriptionText: String
    var itemImage1: String
    var itemImage2: String
    var itemImage3: String
    var itemImage4: String
    var itemImage5: String
    var itemImage6: String
    var id: Int
    //var isLiked: Bool = false
    //var id: Int
    //var comments: [Comment]
}
