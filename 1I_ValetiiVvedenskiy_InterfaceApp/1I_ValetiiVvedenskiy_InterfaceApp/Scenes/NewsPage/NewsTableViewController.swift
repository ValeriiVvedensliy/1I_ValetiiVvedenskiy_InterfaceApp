//
//  NewsTableViewController.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 09.08.2021.
//

import UIKit

class NewsTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var images = ["albert", "albert_2", "junior", "milan", "sport"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        registerNib()
    }
    
    private func setUpView() {
        tableView.backgroundColor = UIColor.darkGray
        tableView.separatorStyle = .none
        tableView.dataSource = self
    }

    private func registerNib() {
        tableView.register(HeaderViewCell.Nib, forCellReuseIdentifier: HeaderViewCell.Key)
        tableView.register(TextViewCell.Nib, forCellReuseIdentifier: TextViewCell.Key)
        tableView.register(ImagesViewCell.Nib, forCellReuseIdentifier: ImagesViewCell.Key)
        tableView.register(FooterViewCell.Nib, forCellReuseIdentifier: FooterViewCell.Key)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let headerCell = tableView.dequeueReusableCell(
                withIdentifier: HeaderViewCell.Key,
                for: indexPath) as? HeaderViewCell else { return UITableViewCell() }
            headerCell.setUpCell(image: "junior", userName: "Vvedenskiy Valerii", date: "05.10.2021")

            return headerCell
            
        case 1:
            guard let textCell = tableView.dequeueReusableCell(
                withIdentifier: TextViewCell.Key,
                for: indexPath) as? TextViewCell else { return UITableViewCell() }
            textCell.setUpCell(newsText: "Covid-19 В Украине вводится желтая зона")

            return textCell
            
        case 2:
            guard let photoCell = tableView.dequeueReusableCell(
                withIdentifier: ImagesViewCell.Key,
                for: indexPath) as? ImagesViewCell else { return UITableViewCell() }
            
            return photoCell
            
        case 3:
            guard let footerCell = tableView.dequeueReusableCell(
                withIdentifier: FooterViewCell.Key,
                for: indexPath) as? FooterViewCell else { return UITableViewCell() }
            footerCell.setUpCell(likeCount: "5", commentCount: "4", shareCount: "10")

            return footerCell
            
        default:
           return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if let cell = cell as? ImagesViewCell {

            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.tag = indexPath.section
            cell.collectionView.reloadData()

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.Key,
            for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }

        imageCell.setUpCell(image: images[indexPath.row])
        return imageCell
    }
    
}
