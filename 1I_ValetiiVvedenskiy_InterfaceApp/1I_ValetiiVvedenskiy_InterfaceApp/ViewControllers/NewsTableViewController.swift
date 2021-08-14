//
//  NewsTableViewController.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 09.08.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var news: [News] = [News(title: "Group News", image: "group", countLikes: "5", isLike: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        registerNib()
    }
    
    private func setUpView() {
        tableView.backgroundColor = UIColor.darkGray
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.keyboardDismissMode = .interactive
        tableView.dataSource = self
    }

    private func registerNib() {
        tableView.register(NewsTableViewCell.Nib, forCellReuseIdentifier: NewsTableViewCell.Key)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count 
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.Key) as! NewsTableViewCell
        cell.setUpCell(news: news[indexPath.row])
        
      return cell
    }
}
