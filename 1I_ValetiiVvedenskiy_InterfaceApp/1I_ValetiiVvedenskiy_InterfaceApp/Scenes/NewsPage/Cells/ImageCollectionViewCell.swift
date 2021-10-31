//
//  ImageCollectionViewCell.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 22.09.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static var Key = "ImageCollectionViewCell"
    static var Nib = UINib(nibName: "ImageCollectionViewCell", bundle: Bundle(for: ImageCollectionViewCell.self))

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        rootView.layer.cornerRadius = 6
        rootView.layer.masksToBounds = true
        rootView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
    }
    
    func setUpCell(image: String) {
        imageView.image = UIImage(named: image)
    }

}
