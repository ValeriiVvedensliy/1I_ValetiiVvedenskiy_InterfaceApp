//
//  ParalaxTableView.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 12.08.2021.
//

import UIKit

class ParalaxTableView: UITableView {

    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else { return }
        
        let offsetY = -contentOffset.y
        height.constant = max(header.bounds.height, header.bounds.height + offsetY)
        bottom.constant = offsetY >= 0 ? 0 : offsetY / 2
        
        header.clipsToBounds = offsetY <= 0 
    }
}
