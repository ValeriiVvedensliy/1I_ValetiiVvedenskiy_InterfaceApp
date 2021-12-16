//
//  HeaderViewCellModel.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 13.12.2021.
//

import Foundation

class HeaderViewCellModel: CellModel {
  var image: URL
  var userName: String
  var date: String
  
  init(image: URL, userName: String, date: String) {
    self.image = image
    self.userName = userName
    self.date = date
  }
}
