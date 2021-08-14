//
//  News.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 14.08.2021.
//

import Foundation


public class News {
    let title: String
    let image: String
    let countLikes: String
    let isLike: Bool
    
    init(title: String, image: String, countLikes: String, isLike: Bool) {
        self.title = title
        self.image = image
        self.countLikes = countLikes
        self.isLike = isLike
    }
}
