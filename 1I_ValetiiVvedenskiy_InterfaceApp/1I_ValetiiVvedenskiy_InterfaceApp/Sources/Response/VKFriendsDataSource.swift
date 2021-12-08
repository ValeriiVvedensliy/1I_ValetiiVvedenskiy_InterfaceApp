//
//  VKFriendsDataSource.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 20.10.2021.
//

import Foundation
import RealmSwift
import PromiseKit

class VKFriendsDataSource {
  let dataSource = DataSource()
  
  func getData() {
    firstly {
      loadJsonData()
    }.then { data in
      self.parseJsonData(data)
    }.done { friendList in
      self.saveDataToRealm(friendList)
    }.catch { error in
      print(error)
    }
  }
  
  func loadJsonData() -> Promise<Data> {
    return Promise<Data> { (resolver) in
      let configuration = URLSessionConfiguration.default
      let session =  URLSession(configuration: configuration)
      var urlConstructor = URLComponents()
      urlConstructor.scheme = "https"
      urlConstructor.host = "api.vk.com"
      urlConstructor.path = "/method/friends.get"
      urlConstructor.queryItems = [
        URLQueryItem(name: "user_id", value: String(Session.shared.userID)),
        URLQueryItem(name: "fields", value: "photo_50"),
        URLQueryItem(name: "access_token", value: Session.shared.token),
        URLQueryItem(name: "v", value: "5.81")
      ]
      
      session.dataTask(with: urlConstructor.url!) { (data, _, error) in
        if let error = error {
          return resolver.reject(error)
        } else {
          return resolver.fulfill(data ?? Data())
        }
      }.resume()
    }
  }
  
  func parseJsonData(_ data: Data) -> Promise<[RFriend]> {
    return Promise<[RFriend]> { (resolver) in
      do {
        let arrayFriends = try JSONDecoder().decode(ResponseFriends.self, from: data)
        var friendList: [RFriend] = []
        for i in 0...arrayFriends.response.items.count - 1 {
          let name = ((arrayFriends.response.items[i].first_name) + " " + (arrayFriends.response.items[i].last_name))
          let avatar = arrayFriends.response.items[i].photo_50
          let id = String(arrayFriends.response.items[i].id)
          friendList.append(RFriend.init(userName: name, userAvatar: avatar, ownerID: id))
          
        }
        resolver.fulfill(friendList)
      } catch let error {
        resolver.reject(error)
      }
    }
  }
  
  func saveDataToRealm(_ friendList: [RFriend]) {
    self.dataSource.saveFriendsToRealm(friendList)
  }
}
