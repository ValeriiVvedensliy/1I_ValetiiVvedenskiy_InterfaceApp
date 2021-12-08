//
//  Photo.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 17.10.2021.
//

import Foundation

struct ResponsePhoto: Decodable {
    var response: Response

    struct Response: Decodable {
        var count: Int
        var items: [Items]

        struct Items: Decodable {
            var ownerID: Int
            var sizes: [Sizes]
            
            private enum CodingKeys: String, CodingKey {
                case ownerID = "owner_id"
                case sizes
            }
            
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)

                ownerID = try container.decode(Int.self, forKey: .ownerID)
                sizes = try container.decode([Sizes].self, forKey: .sizes)
            }

            struct Sizes: Decodable {
                var url: String
            }
        }
    }
}
