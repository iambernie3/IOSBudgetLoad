//
//  TransactionTopUpCell.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 05/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class TransactionTopUpCell: UITableViewCell {

    @IBOutlet weak var lblTargetMobTel: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
