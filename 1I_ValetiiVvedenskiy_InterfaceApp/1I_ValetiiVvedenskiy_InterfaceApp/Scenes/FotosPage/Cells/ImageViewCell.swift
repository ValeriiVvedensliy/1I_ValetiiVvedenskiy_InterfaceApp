import UIKit
import Kingfisher

class ImageViewCell: UICollectionViewCell {
  
  @IBOutlet public var accountImage: UIImageView!
  @IBOutlet private var likeCount: UILabel!
  @IBOutlet private var likeButton: UIButton!
  
  static var Key = String(describing: ImageViewCell.self)
  static var Nib = UINib(nibName: Key, bundle: Bundle(for: ImageViewCell.self))
  
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
  
  public func setUpCell(url: URL) {
    accountImage.kf.setImage(with: url)
  }
  
  private func startAnimation() {
    let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotation.toValue = Double.pi * 2
    rotation.duration = 1
    rotation.isCumulative = true
    likeButton.layer.add(rotation, forKey: "rotationAnimation")
  }
}
