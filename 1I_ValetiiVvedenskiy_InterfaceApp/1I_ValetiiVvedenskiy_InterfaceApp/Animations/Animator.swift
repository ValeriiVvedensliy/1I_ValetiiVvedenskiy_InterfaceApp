//
//  AnimationManager.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 25.08.2021.
//

import Foundation
import UIKit


final class Animator: NSObject, UIViewControllerAnimatedTransitioning  {
    static let duration: TimeInterval = 1.25
    
    private let type: PresentationType
    private let firstViewController: ImageListCollectionViewController
    private let secondViewController: ImagePreviewViewController
    private var selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    init?(type: PresentationType, firstViewController: ImageListCollectionViewController, secondViewController: ImagePreviewViewController, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot

        guard let window = firstViewController.view.window ?? secondViewController.view.window,
            let selectedCell = firstViewController.selectedCell
            else { return nil }

        self.cellImageViewRect = selectedCell.accountImage.convert(selectedCell.accountImage.bounds, to: window)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let isPresenting = type.isPresenting
        
        guard let toView = isPresenting ? secondViewController.view : firstViewController.view
              else {
                  transitionContext.completeTransition(false)
                  return
          }

          containerView.addSubview(toView)

        guard let selectedCell = firstViewController.selectedCell,
               let window = firstViewController.view.window ?? secondViewController.view.window,
               let cellImageSnapshot = selectedCell.accountImage.snapshotView(afterScreenUpdates: true),
               let controllerImageSnapshot = secondViewController.imageCell.snapshotView(afterScreenUpdates: true)
               else {
                   transitionContext.completeTransition(true)
                   return
           }

           let backgroundView: UIView
           let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = .clear// secondViewController.view.backgroundColor

           if isPresenting {
               selectedCellImageViewSnapshot = cellImageSnapshot
               backgroundView = UIView(frame: containerView.bounds)
               backgroundView.addSubview(fadeView)
               fadeView.alpha = 0
           } else {
               backgroundView = firstViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
               backgroundView.addSubview(fadeView)
           }
           toView.alpha = isPresenting ? 0 : 1
           [backgroundView, selectedCellImageViewSnapshot, controllerImageSnapshot].forEach { containerView.addSubview($0) }

           let controllerImageViewRect = secondViewController.imageCell.convert(secondViewController.imageCell.bounds, to: window)

           [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = (isPresenting ? cellImageViewRect : controllerImageViewRect)
           }

           controllerImageSnapshot.alpha =  isPresenting ? 0 : 1
           selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0

           UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {

               UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                controllerImageSnapshot.frame = isPresenting ? CGRect(x: controllerImageViewRect.minX, y: 0, width: controllerImageViewRect.width, height: controllerImageViewRect.height) : self.cellImageViewRect
                   fadeView.alpha = isPresenting ? 1 : 0
                   self.secondViewController.view.alpha = 0
               }
               UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                   self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                   controllerImageSnapshot.alpha = isPresenting ? 1 : 0
               }
           }, completion: { [self] _ in
                self.selectedCellImageViewSnapshot.removeFromSuperview()
                controllerImageSnapshot.removeFromSuperview()
                backgroundView.removeFromSuperview()

                toView.alpha = 1
                transitionContext.completeTransition(true)
        })
    }
}

enum PresentationType {
    case present
    case dismiss

    var isPresenting: Bool {
        return self == .present
    }
}
