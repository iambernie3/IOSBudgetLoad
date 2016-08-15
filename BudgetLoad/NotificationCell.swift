//
//  NotificationCell.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 12/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var lblLogo: UILabel!
    @IBOutlet weak var lblHeaderContent: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblLogo.layer.cornerRadius = 34.0
        lblLogo.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
