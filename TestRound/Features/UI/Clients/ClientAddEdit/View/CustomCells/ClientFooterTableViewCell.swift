//
//  ClientFooterTableViewCell.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

class ClientFooterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ClientFooterTableViewCell {
    @IBAction func didTapAdd() {
        
    }
}
