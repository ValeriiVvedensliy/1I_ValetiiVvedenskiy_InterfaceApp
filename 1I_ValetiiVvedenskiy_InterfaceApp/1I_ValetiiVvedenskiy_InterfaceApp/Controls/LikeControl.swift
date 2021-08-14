//
//  LikeControl.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 06.08.2021.
//

import UIKit

@IBDesignable
public class LikeControl: UIControl {
    
    private var stackView = UIStackView()
    private var views: [UIView] = []
    private var label: UILabel!
    private var button: UIButton!
    private var count = 0
    
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
        stackView.frame = bounds
    }
    
    private func setupBaseUI() {
        creareLabel()
        setUpImage()
        stackView = UIStackView(arrangedSubviews: views)
        stackView.spacing = -10
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        self.addSubview(stackView)
    }
    
    private func creareLabel() {
        label = UILabel(frame: .zero)
        label.text = "\(count)"
        label.textColor = .blue
        views.append(label)
    }
    
    private func setUpImage() {
        button = UIButton(frame: .zero)
        button.setTitle("♡", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        views.append(button)
    }
    
    @objc private func tapButton(_ sender: UIButton) {
        if count > 0 {
            button.setTitle("♡", for: .normal)
            count -= 1
            label.text = "\(count)"
            button.setTitleColor(.blue, for: .normal)
            label.textColor = .blue
        }
        else {
            button.setTitle("♥︎", for: .normal)
            count += 1
            label.text = "\(count)"
            label.textColor = .red
            button.setTitleColor(.red, for: .normal)
        }
    }
}

