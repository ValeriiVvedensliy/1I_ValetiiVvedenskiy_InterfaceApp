//
//  HeaderViewCell.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 13.09.2021.
//

import UIKit
import Kingfisher

class HeaderViewCell: TableViewCell<HeaderViewCellModel> {
  
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
  
  override func config(item: HeaderViewCellModel) {
    userNameLabel.text = item.userName
    userImageView.kf.setImage(with: item.image)
    dateLabel.text = item.date
    userImageView.layer.cornerRadius = userImageView.bounds.height / 2
  }
}
