//
//  TransferTxnCell.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 08/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class TransferTxnCell: UITableViewCell {

    
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblReciever: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
