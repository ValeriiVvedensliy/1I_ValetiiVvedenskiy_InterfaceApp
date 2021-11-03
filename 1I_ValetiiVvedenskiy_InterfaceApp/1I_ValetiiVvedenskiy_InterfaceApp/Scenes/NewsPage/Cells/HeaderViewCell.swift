//
//  HeaderViewCell.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 13.09.2021.
//

import UIKit

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
  
  func setUpCell(image: String, userName: String, date: String) {
    guard let url = URL(string: image) else { return }
    userNameLabel.text = userName
    userImageView.load(url: url)
    dateLabel.text = date
    userImageView.layer.cornerRadius = userImageView.bounds.height / 2
  }
  
}
