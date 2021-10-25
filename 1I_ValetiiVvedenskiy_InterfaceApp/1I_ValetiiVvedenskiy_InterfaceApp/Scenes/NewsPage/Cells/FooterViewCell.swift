//
//  FooterViewCell.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 13.09.2021.
//

import UIKit

class FooterViewCell: UITableViewCell {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var shareCount: UILabel!
    
    static var Key = "FooterViewCell"
    static var Nib = UINib(nibName: "FooterViewCell", bundle: Bundle(for: FooterViewCell.self))

    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeImageView.tintColor = .white
        commentImageView.tintColor = .white
        shareImageView.tintColor = .white
        likeCount.textColor = .white
        commentCount.textColor = .white
        shareCount.textColor = .white
        rootView.backgroundColor = .darkGray
    }
    
    func setUpCell(likeCount: String, commentCount: String, shareCount: String) {
        self.likeCount.text = likeCount
        self.commentCount.text = commentCount
        self.shareCount.text = shareCount
    }
}
