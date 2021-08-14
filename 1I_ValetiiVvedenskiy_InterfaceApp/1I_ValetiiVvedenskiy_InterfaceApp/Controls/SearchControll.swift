//
//  ProgressBarControll.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 07.08.2021.
//

import UIKit

@IBDesignable
class SearchControll: UIControl, UISearchBarDelegate {

    lazy var searchBar:UISearchBar = UISearchBar()
    var textChangingListener: ((_ text: String) -> ())? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBaseUI()
    }
    

    private func setupBaseUI() {
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        self.addSubview(searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        guard let listener = textChangingListener else { return }
        listener(textSearched)
    }
    
    public func setUpCell(_ textChangingListener: @escaping (_ text: String) -> ()) {
        self.textChangingListener = textChangingListener
    }
}
