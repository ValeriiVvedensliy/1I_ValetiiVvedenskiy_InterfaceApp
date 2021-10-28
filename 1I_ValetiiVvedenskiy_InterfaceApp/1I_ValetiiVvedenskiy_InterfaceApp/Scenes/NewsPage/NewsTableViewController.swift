//
//  NewsTableViewController.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 09.08.2021.
//

import UIKit

class NewsTableViewController: UITableViewController, UICollectionViewDataSource,
                               UICollectionViewDelegateFlowLayout {
  
  var images = ["albert", "albert_2", "junior", "sport"]
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    registerNib()
  }
  
  private func setUpView() {
    tableView.backgroundColor = UIColor.darkGray
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
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
      textCell.setUpCell(newsText: "Back in the days of iOS 6, Apple introduced a wonderful new technology: Auto Layout. Developers rejoiced; parties commenced in the streets; bands wrote songs to celebrate its greatness…")
      
      return textCell
      
    case 2:
      guard let photoCell = tableView.dequeueReusableCell(
        withIdentifier: ImagesViewCell.Key,
        for: indexPath) as? ImagesViewCell else { return UITableViewCell() }
      
      if let layout = photoCell.collectionView?.collectionViewLayout as? CustomLayout {
        layout.delegate = self
      }

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
    return images.count
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let imageCell = collectionView.dequeueReusableCell(
      withReuseIdentifier: ImageCollectionViewCell.Key,
      for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
    
    imageCell.setUpCell(image: images[indexPath.row])
    return imageCell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left
                                                  + collectionView.contentInset.right + 10)) / 2

    return CGSize(width: itemSize, height: itemSize)
  }
  
}

extension NewsTableViewController: CustomLayoutDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    let image = UIImage(named: images[indexPath.item]) ?? UIImage()

      return image.size.height
  }
  
  func collectionView(_ collectionView: UICollectionView) -> Int {
    return images.count
  }

}
