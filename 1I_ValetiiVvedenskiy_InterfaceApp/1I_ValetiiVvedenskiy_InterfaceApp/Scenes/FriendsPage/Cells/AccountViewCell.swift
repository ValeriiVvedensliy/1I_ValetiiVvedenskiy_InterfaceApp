import UIKit

class AccountViewCell: UITableViewCell {

    
    @IBOutlet weak var accountIcon: UIImageView!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountInfo: UILabel!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var messageIcon: UIImageView!
    public static var Key: String = "AccountViewCell"
    static var Nib: UINib = UINib.init(nibName: "AccountViewCell", bundle: Bundle(for:  AccountViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    public func setUpCell(_ account: User) {
        accountName.text = "\(account.firstName) \(account.lastName)"
        accountInfo.text = account.info
        accountIcon.image = UIImage(named: account.images[0] )
        accountIcon.contentMode = .scaleAspectFill
    }
    
    private func setupView() {
        contentView.backgroundColor = UIColor.darkGray
        accountName.textColor = UIColor.white
        accountInfo.textColor = UIColor.white.withAlphaComponent(0.5)
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
