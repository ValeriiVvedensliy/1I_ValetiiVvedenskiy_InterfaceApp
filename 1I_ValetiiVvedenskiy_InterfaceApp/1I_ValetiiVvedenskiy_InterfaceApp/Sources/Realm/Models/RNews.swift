//
//  RNews.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 02.11.2021.

import UIKit
import RealmSwift

class RNews: Object {
  @objc dynamic var name: String = ""
  @objc dynamic var avatar: String = ""
  @objc dynamic var date: String = ""
  @objc dynamic var textNews: String = ""
  @objc dynamic var likes: Int = 0
  @objc dynamic var comments: Int = 0
  @objc dynamic var reposts: Int = 0
  @objc dynamic var imageNews: String = ""
  
  init(
    name: String,
    avatar: String,
    date: String,
    textNews: String,
    imageNews: String,
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
  
  required override init() {
    super.init()
  }
}
