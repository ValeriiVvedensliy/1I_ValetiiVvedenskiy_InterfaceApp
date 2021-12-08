//
//  News.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 02.11.2021.
//

import Foundation
import UIKit

struct ResponseNews: Decodable {
  var response: Response
  
  struct Response: Decodable {
    var items: [Item]
    var groups: [Groups]
    var profiles: [Profiles]
    
    struct Item: Decodable {
      var sourceID: Int
      var date: Double
      var text: String
      var likes: Likes
      var comments: Comments
      var reposts: Reposts
      var views: Views
      var attachments: [Attachments]?
      
      private enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case likes
        case comments
        case reposts
        case views
        case attachments
      }
      
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sourceID = try container.decode(Int.self, forKey: .sourceID)
        date = try container.decode(Double.self, forKey: .date)
        text = try container.decode(String.self, forKey: .text)
        likes = try container.decode(Likes.self, forKey: .likes)
        comments = try container.decode(Comments.self, forKey: .comments)
        reposts = try container.decode(Reposts.self, forKey: .reposts)
        views = try container.decode(Views.self, forKey: .views)
        attachments = try container.decodeIfPresent([Attachments].self, forKey: .attachments)
      }
      
      struct Likes: Decodable {
        var count: Int
      }
      
      struct Comments: Decodable {
        var count: Int
      }
      
      struct Reposts: Decodable {
        var count: Int
      }
      
      struct Views: Decodable {
        var count: Int
      }
      
      struct Attachments: Decodable {
        var type: String
        var photo: Photo?
        var link: Link?
        
        struct Photo: Decodable {
          var sizes: [Sizes]
          
          struct Sizes: Decodable {
            var url: String
          }
        }
        
        struct Link: Decodable {
          var photo: LinkPhoto
          
          struct LinkPhoto: Decodable {
            var sizes: [Sizes]
            
            struct Sizes: Decodable {
              var url: String
            }
          }
        }
      }
    }
    
    struct Groups: Decodable {
      var id: Int
      var name: String
      var avatar: String
      
      private enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
      }
      
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        avatar = try container.decode(String.self, forKey: .avatar)
      }
    }
    
    struct Profiles: Decodable {
      var id: Int
      var firstName: String
      var lastName: String
      var avatar: String
      
      private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
      }
      
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        avatar = try container.decode(String.self, forKey: .avatar)
      }
    }
  }
}
