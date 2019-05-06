//
//  Comment.swift
//  Deal
//
//  Created by Nina Xie on 4/30/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import Foundation

// ************* Hard Code *************
//
//class Comment {
//    let userName: String
//    let message: String
//
//    init(userName: String, message: String) {
//        self.userName = userName
//        self.message = message
//    }
//}


// ************* Codable *************
struct Comment: Codable {
    var userName: String
    var message: String
}

struct CommentsResponse: Codable {
    var success: Bool
    var data: [Comment]
}

struct PostCommentResponse: Codable {
    var success: Bool
}

