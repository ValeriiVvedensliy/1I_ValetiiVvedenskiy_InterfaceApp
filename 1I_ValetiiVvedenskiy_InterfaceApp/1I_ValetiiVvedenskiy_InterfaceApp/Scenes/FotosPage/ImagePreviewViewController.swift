//
//  ImagePreviewViewController.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 20.08.2021.
//
import UIKit
import Foundation

class ImagePreviewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var imgArray = [String]()
    var passedContentOffset: IndexPath!
    var propertyAnimation: UIViewPropertyAnimator!
    var cell: ImagePreviewCell?
    var isCardRotation = false
    var imageCell: UIImageView = UIImageView()
    var interacriveTransition: CustomInterectiveTransition?
    var changedSelectedCellImageViewSnapshot: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagePreviewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isPagingEnabled = false
        self.view.addSubview(collectionView)
        
        collectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.scrollToItem(at: passedContentOffset, at: .centeredHorizontally, animated: false)
        collectionView.isPagingEnabled = true
    }
        
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.itemSize = collectionView.frame.size
        flowLayout.invalidateLayout()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let offset = collectionView.contentOffset
        let width = collectionView.bounds.size.width
        let index = round(offset.x / width)
        let newOffset = CGPoint(x: index * size.width, y: offset.y)
        collectionView.setContentOffset(newOffset, animated: false)

        coordinator.animate(alongsideTransition: { (context) in
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(newOffset, animated: true)
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagePreviewCell
        guard let url = URL(string: imgArray[indexPath.row]) else { return UICollectionViewCell() }
        cell.imgView.load(url: url)
        return cell
    }
            
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPath = getIndexPath()
        cell = collectionView.cellForItem(at: indexPath) as? ImagePreviewCell
        guard let newCell = cell else { return }

        if !isCardRotation {
            isCardRotation.toggle()
            setAnimation(cell: newCell)
            self.imageCell = newCell.imgView
        }

        let percent = scrollView.contentOffset.x / 100
        let animationPercent = min(1, max(0, percent))
        propertyAnimation.fractionComplete = animationPercent
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        propertyAnimation.continueAnimation(withTimingParameters: nil, durationFactor: 0.2)
        cell?.transform = .identity
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
    
    private func getIndexPath() -> IndexPath {
        let offset = collectionView.contentOffset
        let width = collectionView.bounds.size.width
        let index = round(offset.x / width)
        return IndexPath(row: Int(index), section: 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isCardRotation = false
        guard let changedSelectedCellImageViewSnapshot = changedSelectedCellImageViewSnapshot else { return }
        changedSelectedCellImageViewSnapshot()
    }
    
    private func setAnimation(cell: ImagePreviewCell?) {
        let rotation = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 0.8, y: 0.8))
        propertyAnimation = UIViewPropertyAnimator(duration: 2, curve: .easeInOut, animations: {
            cell?.transform = CATransform3DGetAffineTransform(rotation)
        })
        
        propertyAnimation.pauseAnimation()
    }
}

