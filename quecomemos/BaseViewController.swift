//
//  BaseViewController.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 05/04/2018.
//  Copyright © 2018 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        cleanNavBar()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func cleanNavBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
}
