import UIKit

class AccountViewCell: UITableViewCell {

    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var accountText: UILabel!
    
    public static var Key: String = "AccountViewCell"
    static var Nib: UINib = UINib.init(nibName: "AccountViewCell", bundle: Bundle(for:  AccountViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.lightGray
        accountText.textColor = UIColor.white
    }
    
    public func setUpCell(_ accountImage: String, _ accountName: String) {
        self.accountImage.image = UIImage(named: accountImage)
        self.accountText.text = accountName
    }
}
