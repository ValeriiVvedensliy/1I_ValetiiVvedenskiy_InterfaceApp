import UIKit
import Kingfisher

class GroupViewCell: TableViewCell<GroupViewCellModel> {
  
  @IBOutlet private var imageGroup: UIImageView!
  @IBOutlet private var nameGroup: UILabel!
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
    self.isUserInteractionEnabled = false
  }
  
  override func config(item: GroupViewCellModel) {
    self.imageGroup.kf.setImage(with: item.groupLogo)
    self.nameGroup.text = item.groupName
  }
}
