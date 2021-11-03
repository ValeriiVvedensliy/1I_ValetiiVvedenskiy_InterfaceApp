//
//  ImagesViewCell.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 30.09.2021.
//

import UIKit

class ImagesViewCell: UITableViewCell {
  @IBOutlet weak var rootView: UIView!
  @IBOutlet weak var newsImageView: UIImageView!
  
  static var Key = "ImagesViewCell"
  static var Nib = UINib(nibName: "ImagesViewCell", bundle: Bundle(for: ImagesViewCell.self))
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    contentView.backgroundColor = .darkGray
    rootView.backgroundColor = .darkGray
  }
  
  func setUpCell(image: String) {
    guard let url = URL(string: image) else { return }

    newsImageView.load(url: url)
  }
}
