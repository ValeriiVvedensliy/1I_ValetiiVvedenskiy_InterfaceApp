//
//  VKUserDataSource.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 20.10.2021.
//

import Foundation

class VKUserDataSource {

    func loadData() {

        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
                    return
            }

            let array = json as! [[String: Any]]
            let users = array.map { UserJson(json: $0) }

//            for i in 0...users.count-1 {
//            print(users[i].name)
//            }


        }.resume()

    }

}
