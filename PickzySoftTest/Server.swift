//
//  Server.swift
//  PickzySoftTest
//
//  Created by Logesh on 03/01/18.
//  Copyright © 2018 Logesh. All rights reserved.
//

import Foundation
struct Server {
struct ServerData{
    let username: String
    let comments: String
    let img: String
    
    enum CodingKeys : String, CodingKey {
        case username = "username"
        case comments = "comments"
        case img = "img"
    }
}
    let serverdata: ServerData
}
