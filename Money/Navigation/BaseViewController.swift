//
//  ViewController.swift
//  Money
//
//  Created by Gloria Winquist on 7/15/17.
//  Copyright © 2017 glow. All rights reserved.
//

import UIKit

// The BaseViewController has a menu button to control the slide out SWRevealController
class BaseViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var swRevealController: SWRevealViewController?
    var menuViewController: MenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
    }

}
