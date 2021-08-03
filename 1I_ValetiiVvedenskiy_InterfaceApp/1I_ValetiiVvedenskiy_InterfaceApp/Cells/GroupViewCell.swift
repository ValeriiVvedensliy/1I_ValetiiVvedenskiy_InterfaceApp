import UIKit

class GroupViewCell: UITableViewCell {

    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    public static var Key: String = "GroupViewCell"
    static var Nib: UINib = UINib.init(nibName: "GroupViewCell", bundle: Bundle(for:  GroupViewCell.self))
    var addGroup: ((_ name: String) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.lightGray
        nameGroup.textColor = UIColor.white
    }

    public func setUpCell(_ imageGroup: String, _ nameGroup: String, _ buttonIsHide: Bool, _ addGroup: ((_ name: String) -> ())?) {
        self.imageGroup.image = UIImage(named: imageGroup)
        self.nameGroup.text = nameGroup
        self.addGroup = addGroup
        self.addBtn.isHidden = buttonIsHide
    }
    
    @IBAction func addGroup(_ sender: Any) {
        guard let addgroup = addGroup else { return }
        addgroup(nameGroup.text ?? "")
    }
}
