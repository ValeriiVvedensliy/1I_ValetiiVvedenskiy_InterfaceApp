//
//  HeaderViewCell.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 13.09.2021.
//

import UIKit
import Kingfisher

class HeaderViewCell: UITableViewCell {
  
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var rootView: UIView!
  
  static var Key = "HeaderViewCell"
  static var Nib = UINib(nibName: "HeaderViewCell", bundle: Bundle(for: HeaderViewCell.self))
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    rootView.backgroundColor = .darkGray
    userNameLabel.textColor = .white
    dateLabel.textColor = .white
  }
  
  func setUpCell(image: URL, userName: String, date: String) {
    userNameLabel.text = userName
    userImageView.kf.setImage(with: image)
    dateLabel.text = date
    userImageView.layer.cornerRadius = userImageView.bounds.height / 2
  }
  
}
