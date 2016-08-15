//
//  CustomTableCell.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 7/21/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

internal class CustomTableCell: UITableViewCell {
    

    
    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var menuItemIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
