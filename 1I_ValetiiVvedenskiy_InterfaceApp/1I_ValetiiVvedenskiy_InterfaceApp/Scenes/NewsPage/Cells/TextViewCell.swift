//
//  TextViewCell.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 13.09.2021.
//

import UIKit

class TextViewCell: TableViewCell<TextViewCellModel> {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var newsTextLabel: UILabel!

    static var Key = "TextViewCell"
    static var Nib = UINib(nibName: "TextViewCell", bundle: Bundle(for: TextViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rootView.backgroundColor = .darkGray
        newsTextLabel.textColor = .white
    }
    
  override func config(item: TextViewCellModel) {
    newsTextLabel.text = item.text
  }
}
