import UIKit
import Kingfisher

class GroupViewCell: UITableViewCell {
  
  @IBOutlet private var imageGroup: UIImageView!
  @IBOutlet private var nameGroup: UILabel!
  @IBOutlet private var addBtn: UIButton!
  @IBOutlet private var rootView: UIView!
  
  static var Key = String(describing: GroupViewCell.self)
  static var Nib = UINib(nibName: Key, bundle: Bundle(for: GroupViewCell.self))
  
  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.backgroundColor = UIColor.clear
    nameGroup.textColor = UIColor.white
    imageGroup.contentMode = .scaleAspectFill
    rootView.backgroundColor = .clear
    self.backgroundColor = .clear
  }
  
  public func setUpCell(_ imageGroup: URL, _ nameGroup: String, _ buttonIsHide: Bool) {
    self.imageGroup.kf.setImage(with: imageGroup)
    self.nameGroup.text = nameGroup
    self.addBtn.tintColor = .white
    self.addBtn.isHidden = buttonIsHide
    self.isUserInteractionEnabled = false
  }
}
