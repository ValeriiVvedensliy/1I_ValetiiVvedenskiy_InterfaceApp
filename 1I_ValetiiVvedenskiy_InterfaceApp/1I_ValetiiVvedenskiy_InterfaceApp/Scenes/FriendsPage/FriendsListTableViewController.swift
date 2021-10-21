import UIKit

class FriendsListTableViewController: UITableViewController {
    
    private var vkLoader = VKDataSource()
    private var vkFriendsLoader = VKFriendsDataSource()
    private var friends: [Friend] = []
    
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
        tableView.register(AccountViewCell.Nib, forCellReuseIdentifier: AccountViewCell.Key)
    }
    
    private func setUpData() {
        vkLoader.loadData(.usersInfo)
        vkFriendsLoader.loadData() { [weak self] (complition) in
               DispatchQueue.main.async {
                   self?.friends = complition
                   self?.tableView.reloadData()
               }
           }
    }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountViewCell.Key) as! AccountViewCell
        let account = friends[indexPath.row]
        
        cell.setUpCell(account)

      return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? AccountViewCell
        cell!.startAnimation(completion: completion, indexPath: indexPath)
   }
        
    private func completion(indexPath: IndexPath) {
        let account = friends[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ImageListCollectionViewController") as! ImageListCollectionViewController
        vc.owner_id = account.owner_id
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
