//
//  GroupViewCellModel.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 08.12.2021.
//

import Foundation

class GroupViewCellModel: CellModel {
  var groupName: String
  var groupLogo: URL
  
  init(groupName: String, groupLogo: URL) {
    self.groupName = groupName
    self.groupLogo = groupLogo
  }
}
