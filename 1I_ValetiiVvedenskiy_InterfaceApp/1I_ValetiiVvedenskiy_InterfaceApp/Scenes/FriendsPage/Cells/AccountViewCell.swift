import UIKit
import Kingfisher

class AccountViewCell: UITableViewCell {
  
  
  @IBOutlet private var accountIcon: UIImageView!
  @IBOutlet private var accountName: UILabel!
  @IBOutlet private var phoneIcon: UIImageView!
  @IBOutlet private var messageIcon: UIImageView!
  
  static var Key = String(describing: AccountViewCell.self)
  static var Nib = UINib(nibName: Key, bundle: Bundle(for: AccountViewCell.self))
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  public func setUpCell(_ account: Friend) {
    accountName.text = "\(account.userName)"
    accountIcon.kf.setImage(with: account.userAvatar)
    accountIcon.contentMode = .scaleAspectFill
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
