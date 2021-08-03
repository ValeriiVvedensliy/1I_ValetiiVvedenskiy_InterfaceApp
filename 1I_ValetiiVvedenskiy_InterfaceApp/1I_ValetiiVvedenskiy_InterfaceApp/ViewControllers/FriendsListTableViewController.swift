import UIKit

class FriendsListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
      super.viewDidLoad()
      setUpView()
    }
    
    private func setUpView() {
        tableView.backgroundColor = UIColor.darkGray
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.keyboardDismissMode = .interactive
        tableView.dataSource = self
    }
}
