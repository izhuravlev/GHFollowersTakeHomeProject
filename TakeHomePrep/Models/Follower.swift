//
//  Follower.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-15.
//

import Foundation

struct Follower: Codable, Hashable {
    // safe to make them not optional
    var login: String
    var avatarUrl: String
    
}
