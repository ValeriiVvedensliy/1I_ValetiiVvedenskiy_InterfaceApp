//
//  FooterViewCellModel.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 13.12.2021.
//

import Foundation

class FooterViewCellModel: CellModel {
  var likeCount: String
  var commentCount: String
  var shareCount: String
  
  init(likeCount: String, commentCount: String, shareCount: String) {
    self.likeCount = likeCount
    self.commentCount = commentCount
    self.shareCount = shareCount
  }
}
