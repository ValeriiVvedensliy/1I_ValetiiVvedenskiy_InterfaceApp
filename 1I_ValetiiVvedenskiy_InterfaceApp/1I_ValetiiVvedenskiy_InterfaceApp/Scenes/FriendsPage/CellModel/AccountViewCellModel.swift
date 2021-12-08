//
//  AccountViewCellModel.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 08.12.2021.
//

import Foundation
struct AccountViewCellModel: CellModel {
  var userName: String
  var userAvatar: URL
  var ownerID: String
  
  init(userName: String, userAvatar: URL, ownerID: String) {
    self.userName = userName
    self.userAvatar = userAvatar
    self.ownerID = ownerID
  }
}
