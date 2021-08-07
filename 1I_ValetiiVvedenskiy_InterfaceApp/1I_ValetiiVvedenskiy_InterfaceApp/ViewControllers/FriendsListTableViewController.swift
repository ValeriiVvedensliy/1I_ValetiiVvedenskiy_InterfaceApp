import UIKit

class FriendsListTableViewController: UITableViewController {
    
    @IBOutlet weak var filterView: SearchControll!
    
    private var users: [User]?
    private var dataSource: MockDataSource?
    
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
        filterView.setUpCell(filterAccount)
    }
    
    private func registerNib() {
        tableView.register(AccountViewCell.Nib, forCellReuseIdentifier: AccountViewCell.Key)
    }
    
    private func setUpData() {
        dataSource = MockDataSource()
        users = dataSource?.getUsers()
    }
    
    private func filterAccount(accountsName: String) {
        let newUsers = users?.filter({$0.firstName.contains(accountsName)})
        if newUsers?.count ?? 0 > 0 {
            users = newUsers
        }
        else {
            users = dataSource?.getUsers()
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let accounts = users else { fatalError() }
        let account = accounts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountViewCell.Key) as! AccountViewCell
        cell.setUpCell(account.images[0], account.firstName + " " + account.lastName)

      return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let accounts = users else { fatalError() }
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ImageListCollectionViewController") as! ImageListCollectionViewController
        vc.images = accounts[indexPath.row].images
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
   }
}
