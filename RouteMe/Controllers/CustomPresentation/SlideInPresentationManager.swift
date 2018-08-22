//
//  SlideInPresentationManager.swift
//  RouteMe
//
//  Created by Long Nguyen on 18/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction, sizeInParentContainer: sizeInParentContainer)
        
        return presentationController
    }
}

class SlideInPresentationManager: NSObject {
    
    var direction = PresentationDirection.left
    
    var sizeInParentContainer: CGFloat = 2 / 3

}
