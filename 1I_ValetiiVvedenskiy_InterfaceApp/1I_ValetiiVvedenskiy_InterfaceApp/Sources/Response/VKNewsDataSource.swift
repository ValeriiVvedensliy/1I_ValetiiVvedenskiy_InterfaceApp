//
//  VKNewsDataSource.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 02.11.2021.
//

import Foundation
import RealmSwift
import SwiftyJSON

class VKNewsDataSource {
  let dataSource = DataSource()
  var news: [News] = []

  func loadData(isDataSourcePrefetching: Bool,
                nextPageNews nextNewsID: String = "",
                completion: (([News], String) -> Void)? = nil) {
    let configuration = URLSessionConfiguration.default
    let session =  URLSession(configuration: configuration)
    
    var urlConstructor = URLComponents()
    urlConstructor.scheme = "https"
    urlConstructor.host = "api.vk.com"
    urlConstructor.path = "/method/newsfeed.get"
    urlConstructor.queryItems = [
      URLQueryItem(name: "owner_id", value: String(Session.shared.userID)),
      URLQueryItem(name: "access_token", value: Session.shared.token),
      URLQueryItem(name: "filters", value: "post,photo"),
      URLQueryItem(name: "start_from", value: nextNewsID),
      URLQueryItem(name: "count", value: "10"),
      URLQueryItem(name: "v", value: "5.81")
    ]
    
    let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
      
      guard let data = data else { return }
      
      do {
        let arrayNews = try JSONDecoder().decode(ResponseNews.self, from: data)
        let json = try? JSON(data: data)
        let nextFrom = json?["response"]["next_from"].stringValue

        guard arrayNews.response.items.isEmpty == false else { return }
        
        var avatar: String = ""
        var name: String = ""
        var strDate: String
        var text: String
        var urlImage: String = ""
        var newsList: [RNews] = []
        
        for i in 0...arrayNews.response.items.count-1 {
          let typeNews = arrayNews.response.items[i].attachments?.first?.type
          guard typeNews != "link" || typeNews != "photo" else { return }
          
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
          let date = Date(timeIntervalSince1970: arrayNews.response.items[i].date)
          strDate = dateFormatter.string(from: date)
          
          text = arrayNews.response.items[i].text
          
          if typeNews == "link" {
            urlImage = arrayNews.response.items[i].attachments?.first?.link?.photo.sizes.first?.url ?? ""
          }
          if typeNews == "photo" {
            urlImage = arrayNews.response.items[i].attachments?.first?.photo?.sizes.last?.url ?? ""
          }
          
          let likes = arrayNews.response.items[i].likes.count
          let comments = arrayNews.response.items[i].comments.count
          let reposts = arrayNews.response.items[i].reposts.count
          
          let sourceID = arrayNews.response.items[i].sourceID * -1
          for i in 0...arrayNews.response.groups.count-1 {
            if arrayNews.response.groups[i].id == sourceID {
              name = arrayNews.response.groups[i].name
              avatar = arrayNews.response.groups[i].avatar
            }
          }
          if !isDataSourcePrefetching {
            newsList.append(RNews(
              name: name,
              avatar: avatar,
              date: strDate,
              textNews: text,
              imageNews: urlImage,
              likes: likes,
              comments: comments,
              reposts: reposts
            ))
          } else {
            self.news.append(News(
              name: name,
              avatar: avatar.loadImage(),
              date: strDate,
              textNews: text,
              imageNews: urlImage.loadImage(),
              likes: likes,
              comments: comments,
              reposts: reposts
            ))
          }

        }
        DispatchQueue.main.async {
          if !isDataSourcePrefetching {
            self.dataSource.saveNewsToRealm(newsList)
          } else {
            guard let completion = completion else { return }
            completion(self.news, nextFrom ?? "")
          }
        }
      } catch let error {
        print(error)
      }
    }
    task.resume()
  }
}
