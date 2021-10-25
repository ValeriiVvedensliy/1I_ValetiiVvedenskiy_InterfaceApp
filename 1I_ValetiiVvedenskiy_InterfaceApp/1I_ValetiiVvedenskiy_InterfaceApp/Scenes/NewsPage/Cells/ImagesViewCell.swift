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
        setLayout()
        registerNib()
    }
    
    private func registerNib() {
        collectionView.register(ImageCollectionViewCell.Nib, forCellWithReuseIdentifier: ImageCollectionViewCell.Key)
    }
    
    private func setLayout() {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
        collectionView.collectionViewLayout = layout
        collectionView.collectionViewLayout = layout
    }
}
