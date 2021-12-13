//
//  Photo.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 04.11.2021.
//

import Foundation
import UIKit

class Photo {
  var photo: URL
  var ownerID: String
  
  init(photo: URL, ownerID: String) {
    self.photo = photo
    self.ownerID = ownerID
  }
}
