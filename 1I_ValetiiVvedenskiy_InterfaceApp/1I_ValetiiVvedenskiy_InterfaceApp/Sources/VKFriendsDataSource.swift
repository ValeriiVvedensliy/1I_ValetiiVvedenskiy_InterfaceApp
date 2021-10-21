//
//  VKFriendsDataSource.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 20.10.2021.
//

import Foundation

class VKFriendsDataSource {
    func loadData(complition: @escaping ([Friend]) -> Void ) {

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
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let arrayFriends = try JSONDecoder().decode(Friends.self, from: data)
                var fullNamesFriends: [Friend] = []
                for i in 0...arrayFriends.response.items.count-1 {
                    let name = ((arrayFriends.response.items[i].first_name) + " " + (arrayFriends.response.items[i].last_name))
                    let avatar = arrayFriends.response.items[i].photo_50
                    let id = String(arrayFriends.response.items[i].id)
                    fullNamesFriends.append(Friend.init(userName: name, userAvatar: avatar, owner_id: id))
                }
                complition(fullNamesFriends)
            } catch let error {
                print(error)
                complition([])
            }
        }
        task.resume()
    }
    
}
