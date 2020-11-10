//
//  UIViewControllerExtension.swift
//  GoalPost-app
//
//  Created by Maksim Ponomarev on 03.11.2020.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
//        let transition = CATransition()
//        transition.duration = 0.3
//        transition.type = CATransitionType.moveIn
//        transition.subtype = CATransitionSubtype.fromRight
//        self.view.window?.layer.add(transition, forKey: kCATransition)
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func presentSecondaryDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        guard let presentedViewController = presentedViewController else {return}
        presentedViewController.dismiss(animated: false) {

            viewControllerToPresent.modalTransitionStyle = .flipHorizontal
            viewControllerToPresent.modalPresentationCapturesStatusBarAppearance = true
            viewControllerToPresent.modalPresentationStyle = .fullScreen
            
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
}
    
    func dismissDetail() {
//    let transition = CATransition()
//        transition.duration = 0.3
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromLeft
//        transition.fillMode = .backwards
//        transition.accessibilityViewIsModal = true
//        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
}
