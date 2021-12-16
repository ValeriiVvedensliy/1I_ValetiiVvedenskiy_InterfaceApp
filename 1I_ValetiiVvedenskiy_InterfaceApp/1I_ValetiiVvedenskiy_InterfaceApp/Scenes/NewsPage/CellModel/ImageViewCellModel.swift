//
//  ImageViewCellModel.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 13.12.2021.
//

import Foundation

class ImageViewCellModel: CellModel {
  var image: URL
  
  init(image: URL) {
    self.image = image
  }
}
