//
//  ImageAccount.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 06.08.2021.
//

import UIKit

@IBDesignable
public class ImageAccount: UIView {
    
    private var shadowView: UIView!
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBaseUI()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupBaseUI() {
        shadowView = UIView(frame: self.frame)
        shadowView.layer.cornerRadius = shadowView.frame.height / 2
        shadowView.backgroundColor = UIColor.black
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOpacity = 1
        self.addSubview(shadowView)
        
        imageView = UIImageView(frame: self.frame)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.masksToBounds = true
        self.addSubview(imageView)
    }
    
    public func setUpCell(_ accountImage: String) {
        imageView.image = UIImage(named: accountImage)
    }
}
