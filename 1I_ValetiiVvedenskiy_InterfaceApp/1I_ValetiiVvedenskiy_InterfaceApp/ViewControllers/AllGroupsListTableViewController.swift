import Foundation


import UIKit

class AllGroupsListTableViewController: UITableViewController {
    
    private var groups: [Group]?
    public var dataSource: MockDataSource?
    
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
        tableView.estimatedRowHeight = 44
        tableView.keyboardDismissMode = .interactive
        tableView.dataSource = self
    }
    
    private func registerNib() {
        tableView.register(GroupViewCell.Nib, forCellReuseIdentifier: GroupViewCell.Key)
    }
    
    private func setUpData() {
        groups = dataSource?.getAllGroups()
    }
    
    private func addGroup(name: String) {
        let isAdded = dataSource?.addGroupByUser(groupName: name)
        showPopUpInfo(isAdded: isAdded ?? false)
    }
    
    private func showPopUpInfo(isAdded: Bool) {
        var title = ""
        var message = ""
        
        if isAdded {
            title = "Success"
            message = "Group was add"
        } else {
            title = "Error"
            message = "You have already added this group"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        cell.setUpCell(group.image, group.name, false, addGroup)

      return cell
    }
}
