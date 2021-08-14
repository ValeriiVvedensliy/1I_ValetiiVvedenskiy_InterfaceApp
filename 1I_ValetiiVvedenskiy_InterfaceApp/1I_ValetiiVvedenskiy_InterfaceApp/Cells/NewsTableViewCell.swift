//
//  NewsTableViewCell.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 14.08.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var likeNews: UILabel!
    @IBOutlet weak var countLikes: UILabel!
    
    public static var Key: String = "NewsTableViewCell"
    static var Nib: UINib = UINib.init(nibName: "NewsTableViewCell", bundle: Bundle(for:  NewsTableViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeNews.textColor = .red
        countLikes.textColor = .red
    }

    public func setUpCell(news: News) {
        title.text = news.title
        likeNews?.text = news.isLike ? "♥︎" : "♡"
        countLikes?.text = news.countLikes
    }
    
}
