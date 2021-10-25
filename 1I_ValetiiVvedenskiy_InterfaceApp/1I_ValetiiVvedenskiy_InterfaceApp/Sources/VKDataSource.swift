//
//  VKDataSource.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 13.10.2021.
//

import Foundation
class VKDataSource {

    func loadData(_ setting: settingsApi) {

        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)

        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.81")
        ]

        switch setting {
        case .usersInfo:
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.shared.userID)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
        case .photos:
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems?.append(URLQueryItem(name: "owner_id", value: String(Session.shared.userID)))
        case .groups:
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.shared.userID)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        }

        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data) else { return }

            print("Вывод json из ответа: \(String(describing: json))")
        }
    
        task.resume()
    }
}
