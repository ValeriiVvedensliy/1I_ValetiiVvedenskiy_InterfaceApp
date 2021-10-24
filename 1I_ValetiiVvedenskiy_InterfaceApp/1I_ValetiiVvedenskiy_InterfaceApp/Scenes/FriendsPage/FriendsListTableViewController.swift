import UIKit
import RealmSwift

class FriendsListTableViewController: UITableViewController {
    
    private var vkLoader = VKDataSource()
    private var vkFriendsLoader = VKFriendsDataSource()
    private var friends: [RFriend] = []
    
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

        loadFriendsFromRealm()
        vkFriendsLoader.loadData() { [weak self] () in
                self?.loadFriendsFromRealm()
        }
    }
    
    func loadFriendsFromRealm() {
        do {
            let realm = try Realm()
            let friendsFromRealm = realm.objects(RFriend.self)
            friends = Array(friendsFromRealm)
            
            guard friends.count != 0 else { return } // проверка, что в реалме что-то есть
            tableView.reloadData()
        } catch {
            print(error)
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
        vc.owner_id = account.ownerID
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
