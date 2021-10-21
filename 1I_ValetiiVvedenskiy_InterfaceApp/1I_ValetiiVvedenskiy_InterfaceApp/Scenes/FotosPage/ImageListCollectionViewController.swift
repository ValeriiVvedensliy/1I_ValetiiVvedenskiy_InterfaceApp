import UIKit


class ImageListCollectionViewController: UICollectionViewController, UINavigationControllerDelegate {
    
    public var owner_id = ""
    var selectedCell: ImageViewCell?
    var selectedCellImageViewSnapshot: UIView?
    var animator: Animator?
    let interacriveTransition = CustomInterectiveTransition()
    
    private var images: [String]?
    private var imageSource = VKPhotoDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        collectionView.backgroundColor = UIColor.darkGray
        setUpNavigationBarTitle()
        setLayout()
        registerNib()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    private func setLayout() {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    private func registerNib() {
        collectionView.register(ImageViewCell.Nib, forCellWithReuseIdentifier: ImageViewCell.Key)
    }
    
    private func loadData() {
        imageSource.loadData(owner_id: owner_id) { [weak self] (complition) in
             DispatchQueue.main.async {
                 self?.images = complition
                 self?.collectionView.reloadData()
             }
         }
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
        selectedCell = collectionView.cellForItem(at: indexPath) as? ImageViewCell
        selectedCellImageViewSnapshot = selectedCell?.accountImage.snapshotView(afterScreenUpdates: false)
        
        let vc = ImagePreviewViewController()
        vc.imgArray = self.images ?? []
        vc.passedContentOffset = indexPath
        vc.imageCell = UIImageView(frame: collectionView.layer.bounds)
        guard let url = URL(string: images?[indexPath.row] ?? "") else { return }
        vc.imageCell.load(url: url)
        vc.interacriveTransition = interacriveTransition
        vc.changedSelectedCellImageViewSnapshot = changedSelectedCellImageViewSnapshot
        
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func changedSelectedCellImageViewSnapshot () {
        selectedCellImageViewSnapshot = nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            guard let firstViewController = fromVC as? ImageListCollectionViewController,
                  let secondViewController = toVC as? ImagePreviewViewController,
                  let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }
            
            if navigationController.viewControllers.first != toVC {
                interacriveTransition.viewController = toVC
            }
            animator = Animator(type: .present, firstViewController: firstViewController, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
            return animator
        case .pop:
            guard let secondViewController = fromVC as? ImagePreviewViewController,
                  let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }
            
            interacriveTransition.viewController = self
            animator = Animator(type: .dismiss, firstViewController: self, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
            return animator
        case .none:
            return nil
        @unknown default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        interacriveTransition.hasStarted ? interacriveTransition : nil
    }
}
