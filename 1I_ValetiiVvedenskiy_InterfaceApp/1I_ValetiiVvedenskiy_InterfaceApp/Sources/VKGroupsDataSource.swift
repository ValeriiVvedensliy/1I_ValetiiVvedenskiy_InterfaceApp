//
//  VKGroupsDataSource.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 21.10.2021.
//

import Foundation
import RealmSwift

class VKGroupsDataSource {
    let dataSource = DataSource()
    func loadData(complition: @escaping () -> Void ) {
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.shared.userID)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.81")
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let arrayGroups = try JSONDecoder().decode(Groups.self, from: data)
                var fullGroupList: [RGroup] = []
                for i in 0...arrayGroups.response.items.count-1 {
                    let name = ((arrayGroups.response.items[i].name))
                    let avatar = arrayGroups.response.items[i].photo_50
                    fullGroupList.append(RGroup.init(groupName: name, groupLogo: avatar))
                }
                DispatchQueue.main.async {
                    self.dataSource.saveGroupsToRealm(fullGroupList)
                    complition()
                }
            } catch let error {
                print(error)
                complition()
            }
        }
        task.resume()
    }
}
