import Foundation


import UIKit

class GroupsListTableViewController: UITableViewController {
    
    private var groups: [Group]?
    private var dataSource = VKGroupsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        registerNib()
        setUpData()
    }
    
    private func setUpView() {
        tableView.backgroundColor = UIColor.darkGray
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.keyboardDismissMode = .interactive
        tableView.dataSource = self
    }
        
    private func registerNib() {
        tableView.register(GroupViewCell.Nib, forCellReuseIdentifier: GroupViewCell.Key)
    }
    
    private func setUpData() {
        dataSource.loadData() { [weak self] (complition) in
            DispatchQueue.main.async {
                self?.groups = complition
                self?.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groups = groups else { fatalError() }
        let group = groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupViewCell.Key) as! GroupViewCell
        cell.setUpCell(group.image, group.name, true, nil)

      return cell
    }
}
