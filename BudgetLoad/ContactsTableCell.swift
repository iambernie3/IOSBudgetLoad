//
//  ContactsTableCell.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 27/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class ContactsTableCell: UITableViewCell {

    @IBOutlet weak var lblFirstLetter: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblFirstLetter.layer.masksToBounds = true
        self.lblFirstLetter.layer.cornerRadius = 19.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
