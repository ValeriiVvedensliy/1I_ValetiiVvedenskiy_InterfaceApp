//
//  ImageView.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 20.10.2021.
//

import UIKit

extension String {
  func loadImage() -> URL {
    guard let url = URL(string: self) else { return URL(fileURLWithPath: "")}
    
    return url
  }
}
