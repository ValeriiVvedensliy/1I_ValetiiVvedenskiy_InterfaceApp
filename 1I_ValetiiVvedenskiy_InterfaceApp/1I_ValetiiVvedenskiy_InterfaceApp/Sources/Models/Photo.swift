//
//  Photo.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 17.10.2021.
//

import Foundation

struct Photo: Decodable {
    var response: Response

    struct Response: Decodable {
        var count: Int
        var items: [Items]

        struct Items: Decodable {
            var album_id: Int
            var date: Int
            var id: Int
            var owner_id: Int
            var has_tags: Bool
            var sizes: [Sizes]
            var text: String

            struct Sizes: Decodable {
                var height: Int
                var url: String
                var type: String
                var width: Int
            }
        }
    }
}
