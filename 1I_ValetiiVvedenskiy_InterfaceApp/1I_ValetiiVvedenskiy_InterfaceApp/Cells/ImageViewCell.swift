import UIKit

class ImageViewCell: UICollectionViewCell {

    @IBOutlet weak var accountImage: UIImageView!
    
    public static var Key: String = "ImageViewCell"
    static var Nib: UINib = UINib.init(nibName: "ImageViewCell", bundle: Bundle(for:  ImageViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.lightGray
    }
    
    public func setUpCell(_ accountImage: String) {
        self.accountImage.image = UIImage(named: accountImage)
    }
}
