import Foundation
import RealmSwift
import UIKit

class GroupsListTableViewController: UITableViewController {
    
    private var groups: [RGroup]?
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
        loadGroupsFromRealm()
        
        dataSource.loadData() { [weak self] () in
            self?.loadGroupsFromRealm()
        }
    }
    
    func loadGroupsFromRealm() {
        do {
            let realm = try Realm()
            let groupsFromRealm = realm.objects(RGroup.self)
            groups = Array(groupsFromRealm)
            guard groupsFromRealm.count != 0 else { return }
            tableView.reloadData()
        } catch {
            print(error)
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
        cell.setUpCell(group.groupLogo, group.groupName, true, nil)

      return cell
    }
}
