import UIKit

class GroupViewCell: UITableViewCell {

    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var rootView: UIView!
    
    public static var Key: String = "GroupViewCell"
    static var Nib: UINib = UINib.init(nibName: "GroupViewCell", bundle: Bundle(for:  GroupViewCell.self))
    var addGroup: ((_ name: String) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.clear
        nameGroup.textColor = UIColor.white
        imageGroup.contentMode = .scaleAspectFill
        rootView.backgroundColor = .clear
        self.backgroundColor = .clear
    }

    public func setUpCell(_ imageGroup: String, _ nameGroup: String, _ buttonIsHide: Bool, _ addGroup: ((_ name: String) -> ())?) {
        guard let url = URL(string: imageGroup) else { return }
        self.imageGroup.load(url: url)
        self.nameGroup.text = nameGroup
        self.addGroup = addGroup
        self.addBtn.tintColor = .white
        self.addBtn.isHidden = buttonIsHide
    }
    
    @IBAction func addGroup(_ sender: Any) {
        guard let addgroup = addGroup else { return }
        addgroup(nameGroup.text ?? "")
    }
}
