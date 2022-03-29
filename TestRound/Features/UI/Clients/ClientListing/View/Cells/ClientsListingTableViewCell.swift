//
//  ClientsListingTableViewCell.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit
import SwipeCellKit

class ClientsListingTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
