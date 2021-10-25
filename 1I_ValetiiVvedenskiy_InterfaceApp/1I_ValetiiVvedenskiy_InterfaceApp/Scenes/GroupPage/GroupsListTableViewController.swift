import Foundation
import RealmSwift
import UIKit

class GroupsListTableViewController: UITableViewController {
    
    private var groups: [RGroup]?
    private var dataSource = VKGroupsDataSource()
    private var notificationToken: NotificationToken?

    var realm: Realm = {
        let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: configrealm)
        return realm
    }()

    lazy var groupsFromRealm: Results<RGroup> = {
        return realm.objects(RGroup.self)
    }()
    
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
        subscribeToNotificationRealm()
        dataSource.loadData()
    }
    
    private func subscribeToNotificationRealm() {
        notificationToken = groupsFromRealm.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.loadGroupsFromRealm()
            case .update:
                self?.loadGroupsFromRealm()
            case let .error(error):
                print(error)
            }
        }
    }
        
    func loadGroupsFromRealm() {
            groups = Array(groupsFromRealm)
            guard groupsFromRealm.count != 0 else { return }
            tableView.reloadData()
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
