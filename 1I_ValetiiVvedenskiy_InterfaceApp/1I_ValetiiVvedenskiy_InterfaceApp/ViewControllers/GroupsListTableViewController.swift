import Foundation


import UIKit

class GroupsListTableViewController: UITableViewController {
    
    private var groups: [Group]?
    private var dataSource: MockDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        registerNib()
        setUpData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groups = dataSource?.getGroups()
        tableView.reloadData()
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
        tableView.register(GroupViewCell.Nib, forCellReuseIdentifier: GroupViewCell.Key)
    }
    
    private func setUpData() {
        dataSource = MockDataSource()
    }
    
    // MARK: - Table view data source

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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            groups = dataSource?.deleteGroupByUser(idx: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AllGroupsListTableViewController else { return }
        destination.dataSource = self.dataSource
    }
}