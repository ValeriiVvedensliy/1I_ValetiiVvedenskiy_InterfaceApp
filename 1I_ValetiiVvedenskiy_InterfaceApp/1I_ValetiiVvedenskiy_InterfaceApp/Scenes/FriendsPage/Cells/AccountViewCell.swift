import UIKit

class AccountViewCell: UITableViewCell {

    
    @IBOutlet weak var accountIcon: UIImageView!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var messageIcon: UIImageView!
    public static var Key: String = "AccountViewCell"
    static var Nib: UINib = UINib.init(nibName: "AccountViewCell", bundle: Bundle(for:  AccountViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    public func setUpCell(_ account: Friend) {
        accountName.text = "\(account.userName)"
        loadAvatar(avatar: account.userAvatar)
        accountIcon.contentMode = .scaleAspectFill
    }
    
    private func loadAvatar(avatar: String) {
        guard let imageUrl = URL(string: avatar) else { return }
        accountIcon.load(url: imageUrl)
    }
    
    private func setupView() {
        contentView.backgroundColor = UIColor.darkGray
        accountName.textColor = UIColor.white
        accountIcon.layer.cornerRadius = accountIcon.bounds.height / 2
    }
    
    public func startAnimation(completion: ((_ indexPath: IndexPath) -> ())?, indexPath: IndexPath) {
        UIView.animate(withDuration: 1, animations: {
            self.accountIcon.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            self.finishAnimation(completion: completion, indexPath: indexPath)
        }
    }
    
    private func finishAnimation(completion: ((_ indexPath: IndexPath) -> ())?, indexPath: IndexPath) {
        UIView.animate(withDuration: 1, animations: {
            self.accountIcon.transform = CGAffineTransform.identity
        }) { _ in
            guard let completion = completion else { return }
            completion(indexPath)
        }
    }
}
