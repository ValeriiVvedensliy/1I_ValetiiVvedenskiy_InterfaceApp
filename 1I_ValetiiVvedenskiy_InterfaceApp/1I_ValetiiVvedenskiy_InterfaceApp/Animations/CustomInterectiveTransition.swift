//
//  CustomInterectiveTransition.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 28.08.2021.
//

import Foundation
import UIKit


class CustomInterectiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
    var viewController: UIViewController? {
        didSet {
            let panGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handle(_:)))
            panGR.edges = .all
            
            viewController?.view.addGestureRecognizer(panGR)
        }
    }
    
    @objc private func handle(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.hasStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            
            shouldFinish = progress > 0.33
            
            update(progress)
        case .ended:
            hasStarted = false
            shouldFinish ? finish() : cancel()
        case .cancelled:
            hasStarted = false
            cancel()
        default: return
        }
    }
}
