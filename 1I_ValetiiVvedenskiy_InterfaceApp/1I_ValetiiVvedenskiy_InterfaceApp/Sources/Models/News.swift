//
//  News.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 04.11.2021.
//

import UIKit

class News {
  var name: String
  var avatar: URL
  var date: String
  var textNews: String
  var likes: Int
  var comments: Int
  var reposts: Int
  var imageNews: URL
  
  init(
    name: String,
    avatar: URL,
    date: String,
    textNews: String,
    imageNews: URL,
    likes: Int,
    comments: Int,
    reposts: Int
  ) {
    self.name = name
    self.avatar = avatar
    self.date = date
    self.textNews = textNews
    self.imageNews = imageNews
    self.likes = likes
    self.comments = comments
    self.reposts = reposts
  }
}

