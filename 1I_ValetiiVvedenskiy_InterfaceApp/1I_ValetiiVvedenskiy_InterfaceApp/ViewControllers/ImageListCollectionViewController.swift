import UIKit


class ImageListCollectionViewController: UICollectionViewController {

    public var images: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.darkGray
        setUpNavigationBarTitle()
        registerNib()
    }
    
    private func setUpNavigationBarTitle() {
      let titleText =  "Images"
      let titleLabel = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 22
        let attributes = [
          NSAttributedString.Key.paragraphStyle: paragraphStyle,
          NSAttributedString.Key.foregroundColor: UIColor.black
        ]
      titleLabel.attributedText = NSAttributedString(string: titleText, attributes: attributes)
        
      navigationItem.titleView = titleLabel
    }

    private func registerNib() {
        collectionView.register(ImageViewCell.Nib, forCellWithReuseIdentifier: ImageViewCell.Key)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.Key, for: indexPath) as! ImageViewCell
        guard let images = images else { return UICollectionViewCell() }
        cell.setUpCell(images[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ImagePreviewViewController()
        vc.imgArray = self.images ?? []
        vc.passedContentOffset = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
