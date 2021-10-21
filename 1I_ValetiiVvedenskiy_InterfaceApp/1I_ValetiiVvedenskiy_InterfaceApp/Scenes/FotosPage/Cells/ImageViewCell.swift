import UIKit

class ImageViewCell: UICollectionViewCell {

    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    public static var Key: String = "ImageViewCell"
    static var Nib: UINib = UINib.init(nibName: "ImageViewCell", bundle: Bundle(for:  ImageViewCell.self))
    
    private var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.clear
        accountImage.contentMode = .scaleAspectFill
        likeCount.textColor = .white
    }
    
    @IBAction func tapLike(_ sender: Any) {
        if count > 0 {
            likeButton.setTitle("♡", for: .normal)
            count -= 1
            likeCount.text = "\(count)"
            likeButton.setTitleColor(.white, for: .normal)
            likeCount.textColor = .white
        }
        else {
            likeButton.setTitle("♥︎", for: .normal)
            count += 1
            likeCount.text = "\(count)"
            likeCount.textColor = .red
            likeButton.setTitleColor(.red, for: .normal)
        }
        startAnimation()
    }
    
    public func setUpCell(_ accountImage: String) {
        guard let url = URL(string: accountImage) else { return }

        self.accountImage.load(url: url)
    }
    
    private func startAnimation() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
           rotation.toValue = Double.pi * 2
           rotation.duration = 1
           rotation.isCumulative = true
           likeButton.layer.add(rotation, forKey: "rotationAnimation")
    }
}
