import UIKit

class AccountViewCell: UITableViewCell {

    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var accountText: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    public static var Key: String = "AccountViewCell"
    static var Nib: UINib = UINib.init(nibName: "AccountViewCell", bundle: Bundle(for:  AccountViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadowView()
        setupView()
    }
    
    public func setUpCell(_ accountImage: String, _ accountName: String) {
        self.accountImage.image = UIImage(named: accountImage)
        self.accountText.text = accountName
    }
    
    private func setupView() {
        contentView.backgroundColor = UIColor.lightGray
        accountText.textColor = UIColor.white
        accountImage.layer.cornerRadius = accountImage.frame.height / 2
    }
    
    private func setupShadowView() {
        shadowView.layer.cornerRadius = shadowView.frame.height / 2
        shadowView.backgroundColor = UIColor.black
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 7
        shadowView.layer.shadowOpacity = 1
    }
}
