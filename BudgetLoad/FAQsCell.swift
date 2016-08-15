//
//  FAQsCell.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 29/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class FAQsCell: UITableViewCell {

    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.layer.borderColor = UIColor.grayColor().CGColor
        lblTitle.layer.borderWidth = 0.5
        lblTitle.textAlignment = NSTextAlignment.Justified
        
        lblDetails.textAlignment = NSTextAlignment.Justified
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
