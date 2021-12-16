//
//  NewsTableViewController.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 09.08.2021.
//

import UIKit
import RealmSwift

class NewsTableViewController: UITableViewController {
  var news: [News]?
  private var dataSource = VKNewsDataSource()
  private var notificationToken: NotificationToken?
  lazy var newsDataSource = VKNewsDataSource()
  var isLoadingNews = false
  var nextNewsID = ""
  let maxRow = 10
  
  var realm: Realm = {
    let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    let realm = try! Realm(configuration: configrealm)
    return realm
  }()
  
  lazy var newsFromRealm: Results<RNews> = {
    return realm.objects(RNews.self)
  }()
  
  let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "dd.MM.yyyy HH:mm:ss"
    return df
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    registerNib()
    setUpData()
    addRefreshControl()
  }
  
  private func setUpView() {
    tableView.backgroundColor = UIColor.darkGray
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.prefetchDataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
  }
  
  private func registerNib() {
    tableView.register(HeaderViewCell.Nib, forCellReuseIdentifier: HeaderViewCell.Key)
    tableView.register(TextViewCell.Nib, forCellReuseIdentifier: TextViewCell.Key)
    tableView.register(ImagesViewCell.Nib, forCellReuseIdentifier: ImagesViewCell.Key)
    tableView.register(FooterViewCell.Nib, forCellReuseIdentifier: FooterViewCell.Key)
  }
  
  private func setUpData() {
    subscribeToNotificationRealm()
    dataSource.loadData(isDataSourcePrefetching: false)
  }
  
  private func subscribeToNotificationRealm() {
    notificationToken = newsFromRealm.observe { [weak self] (changes) in
      switch changes {
      case .initial:
        self?.loadNewsFromRealm()
      case .update:
        self?.loadNewsFromRealm()
      case let .error(error):
        print(error)
      }
      self?.refreshControl?.endRefreshing()
    }
  }
  
  func loadNewsFromRealm() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      
      let rNews = Array(self.newsFromRealm)
      self.news = rNews.map {model -> News in
        News(
          name: model.name,
          avatar: model.avatar.loadImage(),
          date: model.date,
          textNews: model.textNews,
          imageNews: model.imageNews.loadImage(),
          likes: model.likes,
          comments: model.comments,
          reposts: model.reposts)
      }
      self.tableView.reloadData()
    }
  }
  
  private func addRefreshControl() {
    refreshControl = UIRefreshControl()
    refreshControl?.attributedTitle = NSAttributedString(string: "Новости загружаются...")
    refreshControl?.tintColor = .gray
    refreshControl?.addTarget(self, action: #selector(refreshNewsList), for: .valueChanged)
  }
  
  @objc private func refreshNewsList() {
    newsDataSource.loadData(isDataSourcePrefetching: false)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return news?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let news = self.news else { return UITableViewCell() }
    let model = news[indexPath.section]
    switch indexPath.row {
    case 0:
      guard let headerCell = tableView.dequeueReusableCell(
        withIdentifier: HeaderViewCell.Key,
        for: indexPath) as? HeaderViewCell else { return UITableViewCell() }
      headerCell.config(
        item: HeaderViewCellModel(
          image: model.avatar,
          userName: model.name,
          date: model.date
        )
      )

      return headerCell
      
    case 1:
      guard let textCell = tableView.dequeueReusableCell(
        withIdentifier: TextViewCell.Key,
        for: indexPath) as? TextViewCell else { return UITableViewCell() }
      textCell.config(item: TextViewCellModel(text: model.textNews))
      
      return textCell

    case 2:
      guard let photoCell = tableView.dequeueReusableCell(
        withIdentifier: ImagesViewCell.Key,
        for: indexPath) as? ImagesViewCell else { return UITableViewCell() }
      photoCell.config(item: ImageViewCellModel(image: model.imageNews))

      return photoCell
      
    case 3:
      guard let footerCell = tableView.dequeueReusableCell(
        withIdentifier: FooterViewCell.Key,
        for: indexPath) as? FooterViewCell else { return UITableViewCell() }
      footerCell.config(
        item: FooterViewCellModel(
          likeCount: String(model.likes),
          commentCount: String(model.comments),
          shareCount: String(model.reposts)
        )
      )
      
      return footerCell
      
    default:
      return UITableViewCell()
    }
  }
}

extension NewsTableViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    guard isLoadingNews == false,
          let news = news,
          self.maxRow > (news.count - 4) else { return }
    
    isLoadingNews = true
    newsDataSource.loadData(isDataSourcePrefetching: true, nextPageNews: nextNewsID) { [weak self] (nextNews, nextFromID) in
      self?.news?.append(contentsOf: nextNews)
      self?.nextNewsID = nextFromID
      self?.tableView.reloadData()
      self?.isLoadingNews = false
    }
  }
}
