import UIKit

class FriendsListTableViewController: UITableViewController {
    
    var users: [User]? = []
    private var dataSource: MockDataSource?
    private var vkLoader = VKDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        registerNib()
        setUpData()
        vkLoader.loadData(.usersInfo)
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
        tableView.register(AccountViewCell.Nib, forCellReuseIdentifier: AccountViewCell.Key)
    }
    
    private func setUpData() {
        dataSource = MockDataSource()
        users = dataSource?.getUsers()
    }
    
    func sort(_ users: [User]) -> (characters: [Character], sortedUsers: [Character : [User]]) {
        var characters = [Character]()
        var sortedUsers = [Character : [User]]()
        
        users.forEach { user in
            guard let character = user.firstName.first else { return }

            if var thisCharUsers = sortedUsers[character] {
                thisCharUsers.append(user)
                sortedUsers[character] = thisCharUsers
            } else {
                sortedUsers[character] = [user]
                characters.append(character)
            }
        }
        characters.sort()
        return (characters, sortedUsers)
    }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountViewCell.Key) as! AccountViewCell
        
        guard let users = self.users else { return UITableViewCell() }
        
        let account = users[indexPath.row]
        
        cell.setUpCell(account)

      return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? AccountViewCell
        cell!.startAnimation(completion: completion, indexPath: indexPath)
   }
        
    private func completion(indexPath: IndexPath) {
        guard let accounts = users else { fatalError() }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ImageListCollectionViewController") as! ImageListCollectionViewController
        vc.images = accounts[indexPath.row].images
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
