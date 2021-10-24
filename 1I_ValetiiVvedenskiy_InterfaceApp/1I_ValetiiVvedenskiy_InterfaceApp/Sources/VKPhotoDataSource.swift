//
//  VKPhotoDataSource.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 20.10.2021.
//

import Foundation
import RealmSwift

class VKPhotoDataSource {
    func loadData(ownerID: String, complition: @escaping () -> Void ) {
        
        let dataSource = DataSource()
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: ownerID),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.81")
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let arrayPhotosFriend = try JSONDecoder().decode(Photo.self, from: data)
                var photosFriend: [RPhoto] = []
                var ownerID = ""
                for i in 0...arrayPhotosFriend.response.items.count-1 {
                    if let urlPhoto = arrayPhotosFriend.response.items[i].sizes.last?.url {
                        ownerID = String(arrayPhotosFriend.response.items[i].ownerID)
                        photosFriend.append(RPhoto.init(photo: urlPhoto, ownerID: ownerID))
                    }
                }
                DispatchQueue.main.async {
                    dataSource.savePhotosToRealm(photosFriend, ownerID)
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
