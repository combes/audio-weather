//
//  RootViewController.swift
//  AudioWeather
//
//  Created by Christopher Combes on 7/1/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController?
    
    lazy var forecastViewController: ForecastViewController = self.storyboard?.instantiateViewController(withIdentifier: "forecast") as! ForecastViewController
    lazy var mainViewController: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "main-nav") as! UINavigationController
    var animator: UIDynamicAnimator!
    var pushBehavior: UIPushBehavior!
    var gravityBehavior: UIGravityBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the page view controller and add it as a child view controller.
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController!.delegate = self
        self.pageViewController?.dataSource = self
        
        // Create a new view controller
        let viewControllers = [mainViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        
        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        if UIDevice.current.userInterfaceIdiom == .pad {
            pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect
        
        self.pageViewController!.didMove(toParentViewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = self.forecastViewController
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8) {
            
            // Nudge view to provide swipe indication to user
            self.animator = UIDynamicAnimator(referenceView: self.view)
            
            let controller = self.mainViewController.topViewController as! MainViewController
            let aView = controller.view!
            let collision = UICollisionBehavior(items: [aView])
            collision.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0))
            self.animator.addBehavior(collision)
            
            self.gravityBehavior = UIGravityBehavior(items: [aView])
            self.gravityBehavior.gravityDirection = CGVector(dx: 1, dy: 0)
            self.animator.addBehavior(self.gravityBehavior)
            
            let itemBehavior = UIDynamicItemBehavior(items: [aView])
            itemBehavior.elasticity = 0.45
            self.animator.addBehavior(itemBehavior)
            
            // Setup push behavior property for revealing forecast view
            self.pushBehavior = UIPushBehavior(items: [aView], mode: UIPushBehaviorMode.instantaneous)
            self.pushBehavior.magnitude = 0
            self.pushBehavior.angle = 0
            self.pushBehavior.pushDirection = CGVector(dx: -55.0, dy: 0)
            self.animator.addBehavior(self.pushBehavior)
            self.pushBehavior.active = true
        }
    }
    
    // MARK: - UIPageViewControllerDataSource delegate methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == mainViewController {
            return nil
        }
        
        return mainViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController == forecastViewController {
            return nil
        }
        
        return forecastViewController
    }
}
