//
//  EditClientTableViewCell.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit
import PhoneNumberKit

protocol EditClientCellDelegate: NSObjectProtocol {
//    func didTapType(indexPath: IndexPath,type: ProfileSections)
//    func didTapDropDown(indexPath: IndexPath,type: ProfileSections)
//    func didTapOverlay(indexPath: IndexPath,type: ProfileSections)
//    func didTapCross(indexPath: IndexPath,type: ProfileSections)
//    func didTapDeleteAddress(indexPath: IndexPath)
//    func didEndEditing(indexPath: IndexPath,type: ProfileSections,textField: UITextField)
//    func didEndEditing(indexPath: IndexPath,type: ProfileSections,textField: PhoneNumberTextField, extTextField: String)
//    func didEndEditingExtPhone(indexPath: IndexPath, extTextField: UITextField, phoneTextField: String)
}

class EditClientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noTextField: PhoneNumberTextField!
    @IBOutlet weak var valueTextField: UITextField!
    
    @IBOutlet weak var overlayButton: UIButton!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    weak var delegate: EditClientCellDelegate?
    
    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.valueTextField.autocapitalizationType = .words
        self.noTextField.withFlag = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(model: PhoneNumber) {
    }
    
    func bindValue(value: String,placeHolder: String) {
        self.valueTextField.text = value
        self.valueTextField.placeholder = placeHolder
        self.noTextField.text = value
        self.noTextField.placeholder = placeHolder
    }
}

extension EditClientTableViewCell {
    func setIndexPath(indexPath: IndexPath) {
        self.valueTextField.isHidden = false
        self.noTextField.isHidden = true
        self.indexPath = indexPath
        let typeOfSections = ClientSections(rawValue: indexPath.section) ?? .Address
        valueTextField.placeholder = CommonClass.sharedInstance.getSectionHeader(sectionType: typeOfSections)
        if typeOfSections == .PhoneNumber {
            self.valueTextField.isHidden = true
            self.noTextField.isHidden = false
            self.noTextField.placeholder = "Mobile Number"
        }
    }
}

extension EditClientTableViewCell {
    @IBAction func didTapDeleteAddress(){
//        if let index = self.indexPath {
//            self.delegate?.didTapDeleteAddress(indexPath: index)
//        }
    }
    
    @IBAction func didTapCross() {
//        if let index = self.indexPath {
//            let profileSection = ProfileSections(rawValue: index.section) ?? ProfileSections.Phone
//            self.delegate?.didTapCross(indexPath: index,type: profileSection)
//        }
    }
    @IBAction func didTapOverLay() {
//        if let index = self.indexPath {
//            let profileSection = ProfileSections(rawValue: index.section) ?? ProfileSections.Phone
//            self.delegate?.didTapOverlay(indexPath: index,type: profileSection)
//        }
    }
    @IBAction func didTapType() {
//        if let index = self.indexPath {
//            let profileSection = ProfileSections(rawValue: index.section) ?? ProfileSections.Phone
//            self.delegate?.didTapType(indexPath: index,type: profileSection)
//        }
    }
    @IBAction func didTapDropDownButton() {
//        if let index = self.indexPath {
//            let profileSection = ProfileSections(rawValue: index.section) ?? ProfileSections.Phone
//            self.delegate?.didTapDropDown(indexPath: index,type: profileSection)
//        }
    }
    @IBAction func tFEditingChanged(_ sender: UITextField) {
//        if let index = self.indexPath {
//            let profileSection = ProfileSections(rawValue: index.section) ?? ProfileSections.Phone
            /*if let tf = sender as? PhoneNumberTextField {
                self.delegate?.didEndEditing(indexPath: index,type: profileSection, textField: tf, extTextField: self.extensionPhoneTextField.text ?? "")
            } else*/// if sender == self.extensionPhoneTextField{
//                self.delegate?.didEndEditingExtPhone(indexPath: index, extTextField: sender, phoneTextField: self.noTextField.text ?? "")
//            } else {
//                self.delegate?.didEndEditing(indexPath: index,type: profileSection, textField: self.valueTextField)
//            }
//        }
    }
}

extension EditClientTableViewCell: UITextFieldDelegate {

}
