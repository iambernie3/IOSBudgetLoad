//
//  ViewController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 3/28/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var lblsignup: UILabel!
    @IBOutlet weak var lblterms: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        btnStart.backgroundColor = UIColor.clearColor()
        btnStart.layer.cornerRadius = 5
        btnStart.layer.borderWidth = 1
        btnStart.layer.borderColor = UIColor.whiteColor().CGColor
        
        btnStart.hidden = false
        lblsignup.hidden = true
        lblterms.hidden = true
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

