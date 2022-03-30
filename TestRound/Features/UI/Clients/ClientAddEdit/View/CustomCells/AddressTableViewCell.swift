//
//  AddressTableViewCell.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit
import PhoneNumberKit

protocol AddressTableViewCellDelegate: NSObjectProtocol {
    func didDeleteAddress(indexPath: IndexPath)
//    func EndEditing(indexPath: IndexPath,type: ProfileSections,textField: UITextField, index: Int)
}

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deleteAddressBtn: UIButton!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var zipTextField: UITextField!
    
    weak var delegate: AddressTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteAddressAction(_ sender: UIButton) {
        if let index = self.indexPath {
            self.delegate?.didDeleteAddress(indexPath: index)
        }
    }
    
    @IBAction func tfEditingDidChanged(_ sender: UITextField) {
        if let indexPath = self.indexPath {
//            let profileSection = ProfileSections(rawValue: indexPath.section) ?? ProfileSections.Phone
//            if let index = self.valueTextFields.firstIndex(of: sender){
//                self.delegate?.EndEditing(indexPath: indexPath,type: profileSection, textField: self.valueTextFields[index],index: index)
//            }
        }
    }
    
}

extension AddressTableViewCell{
    func bindData(model: Address) {
        self.countryTextField.text = model.country
        self.cityTextField.text = model.city
        self.zipTextField.text = model.zip
        self.streetTextField.text = model.street
    }
}

extension AddressTableViewCell {
    func setIndexPath(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
}
