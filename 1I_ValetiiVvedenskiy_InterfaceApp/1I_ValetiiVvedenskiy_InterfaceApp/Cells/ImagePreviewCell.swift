//
//  ImagePreviewCell.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 20.08.2021.
//
import UIKit
import Foundation

class ImagePreviewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    var imgView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgView = UIImageView()
        imgView.image = UIImage()
        imgView.contentMode = .scaleToFill
        self.addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.frame = self.bounds
    }
}
