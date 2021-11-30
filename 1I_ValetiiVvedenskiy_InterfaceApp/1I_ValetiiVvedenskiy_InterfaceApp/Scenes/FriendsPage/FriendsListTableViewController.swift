import UIKit
import RealmSwift
import PromiseKit

class FriendsListTableViewController: UITableViewController {
  
  private var vkFriendsLoader = VKFriendsDataSource()
  private var friends: [Friend] = []
  var notificationToken: NotificationToken?
  
  var realm: Realm = {
    let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    let realm = try! Realm(configuration: configrealm)
    return realm
  }()
  
  lazy var friendsFromRealm: Results<RFriend> = {
    return realm.objects(RFriend.self)
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
    tableView.register(AccountViewCell.Nib, forCellReuseIdentifier: AccountViewCell.Key)
  }
  
  private func setUpData() {
    subscribeToNotificationRealm()
    vkFriendsLoader.getData()
  }
  
  func loadFriendsFromRealm() {
    DispatchQueue.main.async {
      let rFriends = Array(self.friendsFromRealm)
      self.friends = rFriends.map { model -> Friend in
        Friend(
          userName: model.userName,
          userAvatar: model.userAvatar.loadImage(),
          ownerID: model.ownerID
        )
      }
      
    }
    self.tableView.reloadData()
  }
  
  private func subscribeToNotificationRealm() {
    notificationToken = friendsFromRealm.observe { [weak self] (changes) in
      switch changes {
      case .initial:
        self?.loadFriendsFromRealm()
      case .update:
        self?.loadFriendsFromRealm()
      case let .error(error):
        print(error)
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
    vc.owner_id = account.ownerID
    vc.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(vc, animated: true)
  }
}
