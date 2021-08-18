import UIKit

class FriendsListTableViewController: UITableViewController {
    
    var users: [User]? = []
    private var dataSource: MockDataSource?
    var firstUserCharacters = [Character]()
    var sortUsers: [Character : [User]] = [:]
    
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
        tableView.register(AccountViewCell.Nib, forCellReuseIdentifier: AccountViewCell.Key)
    }
    
    private func setUpData() {
        dataSource = MockDataSource()
        users = dataSource?.getUsers()
        (firstUserCharacters, sortUsers) = sort(users!)
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        firstUserCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let character = firstUserCharacters[section]
        let usersCount = sortUsers[character]?.count
        return usersCount ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountViewCell.Key) as! AccountViewCell
        
        let character = firstUserCharacters[indexPath.section]
        guard let users = sortUsers[character] else { return UITableViewCell() }
        
        let account = users[indexPath.row]
        
        cell.setUpCell(account.images[0], account.firstName + " " + account.lastName)

      return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? AccountViewCell
        cell!.startAnimation(completion: completion, indexPath: indexPath)
   }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(firstUserCharacters[section])
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = .clear
        header.textLabel?.textColor = .white
    }
    
    private func completion(indexPath: IndexPath) {
        guard let accounts = users else { fatalError() }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ImageListCollectionViewController") as! ImageListCollectionViewController
        vc.images = accounts[indexPath.section].images
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
