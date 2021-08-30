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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = true
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagePreviewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isPagingEnabled = true
        self.view.addSubview(collectionView)
        
        collectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
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
        cell.imgView.image = UIImage(named: imgArray[indexPath.row])
        return cell
    }
            
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = collectionView.contentOffset
        let width = collectionView.bounds.size.width
        let index = round(offset.x / width)
        let indexPath = IndexPath(row: Int(index), section: 0)
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isCardRotation = false
    }
    
    private func setAnimation(cell: ImagePreviewCell?) {
        let rotation = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 0.8, y: 0.8))
        propertyAnimation = UIViewPropertyAnimator(duration: 2, curve: .easeInOut, animations: {
            cell?.transform = CATransform3DGetAffineTransform(rotation)
        })
        
        propertyAnimation.pauseAnimation()
    }
}

