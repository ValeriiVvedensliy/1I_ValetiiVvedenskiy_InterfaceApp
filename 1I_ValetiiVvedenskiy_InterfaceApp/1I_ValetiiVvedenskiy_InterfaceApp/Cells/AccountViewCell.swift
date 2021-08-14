import UIKit

class AccountViewCell: UITableViewCell {

    @IBOutlet weak var accountText: UILabel!
    @IBOutlet weak var imageAccount: ImageAccount!
    
    public static var Key: String = "AccountViewCell"
    static var Nib: UINib = UINib.init(nibName: "AccountViewCell", bundle: Bundle(for:  AccountViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    public func setUpCell(_ accountImage: String, _ accountName: String) {
        self.accountText.text = accountName
        imageAccount.layer.cornerRadius = imageAccount.frame.height / 2
        imageAccount.setUpCell(accountImage)
    }
    
    private func setupView() {
        contentView.backgroundColor = UIColor.lightGray
        accountText.textColor = UIColor.white
    }
}
