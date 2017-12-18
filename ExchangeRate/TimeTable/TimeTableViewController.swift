//
//  TimeTableViewController.swift
//  ExchangeRate
//
//  Created by lmcmz on 12/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
