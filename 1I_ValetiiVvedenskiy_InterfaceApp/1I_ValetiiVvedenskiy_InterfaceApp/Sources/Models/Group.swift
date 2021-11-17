//
//  Group.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 04.11.2021.
//

import Foundation
import UIKit

class Group {
  var groupName: String
  var groupLogo: URL
  
  init(groupName: String, groupLogo: URL) {
    self.groupName = groupName
    self.groupLogo = groupLogo
  }
}
