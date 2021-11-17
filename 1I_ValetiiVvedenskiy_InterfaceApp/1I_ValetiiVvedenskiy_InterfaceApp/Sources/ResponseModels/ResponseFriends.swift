//
//  Friends.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 17.10.2021.
//

import Foundation

struct ResponseFriends: Decodable {
    var response: Response

    struct Response: Decodable {
        var count: Int
        var items: [Items]

        struct Items: Decodable {
            var id: Int
            var first_name: String
            var last_name: String
            var photo_50: String
        }
    }
}
