//
//  ImagesViewCell.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 30.09.2021.
//

import UIKit

class ImagesViewCell: UITableViewCell {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static var Key = "ImagesViewCell"
    static var Nib = UINib(nibName: "ImagesViewCell", bundle: Bundle(for: ImagesViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .darkGray
        rootView.backgroundColor = .darkGray
        collectionView.backgroundColor = .darkGray
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        registerNib()
    }
    
    private func registerNib() {
        collectionView.register(ImageCollectionViewCell.Nib, forCellWithReuseIdentifier: ImageCollectionViewCell.Key)
    }
}
