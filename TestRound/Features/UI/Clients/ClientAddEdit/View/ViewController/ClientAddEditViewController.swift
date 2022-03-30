//
//  ClientAddEditViewController.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

class ClientAddEditViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var indvidualButton: UIButton!
    @IBOutlet weak var bussinessButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var viewModel: ClientListingViewModelProtocol?
//    var config = FMPhotoPickerConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
    }
}

// MARK: -  Methods
extension ClientAddEditViewController {
    func setupUI() {
//        self.config.mediaTypes = [.image]
        self.registerNibsAndSetupTableView()
        self.firstNameTextField.autocapitalizationType = .words
        self.lastNameTextField.autocapitalizationType = .words
    }
//    func setupNavBar() {
//        self.title = "Edit Profile"
//        let button1 = UIBarButtonItem(image: UIImage(named: "tick"), style: .plain, target: self, action: #selector(didTapTick))
//        self.navigationItem.rightBarButtonItem  = button1
//    }
    func registerNibsAndSetupTableView(){
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.tableFooterView = UIView()
        
        let nibName = UINib(nibName: "EditProfileTableViewCell", bundle:nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "profileEditCell")
        let sectionNib = UINib(nibName: "ProfileSectionTableViewCell", bundle:nil)
        self.tableView.register(sectionNib, forCellReuseIdentifier: "profileSectionCell")
        let footerNib = UINib(nibName: "ProfileFooterTableViewCell", bundle:nil)
        self.tableView.register(footerNib, forCellReuseIdentifier: "profileFooterCell")
        let addressNib = UINib(nibName: "AddressTableViewCell", bundle:nil)
        self.tableView.register(addressNib, forCellReuseIdentifier: "addressCell")
        self.tableView.estimatedRowHeight = 58
        
        let dummyViewHeight = CGFloat(1)
        let dummyView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        self.tableView.tableHeaderView = dummyView
        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: -dummyViewHeight, right: 0)
    }
}

// MARK: - IBActions
extension ClientAddEditViewController {
    @IBAction func didTapImageCross() {
        self.profileImageView.image = UIImage(named: "user_new")
        self.viewModel.profilePicAttachment.isUpdated = true
        self.contactVM.profilePicAttachment.isUpdated = true
    }
    
    @objc func didTapTick() {
        
    }
    @IBAction func didTapChangeImage() {
        let sheet = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
            //Cancel Action
        }))
        
        
        sheet.addAction(UIAlertAction(title: "Delete Photo",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
            self.didTapImageCross()
        }))
        sheet.addAction(UIAlertAction(title: "Take Photo",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.openCamera()
        }))
        sheet.addAction(UIAlertAction(title: "Choose Photo",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.openPhotoGallery()
        }))
//        CommonClass.sharedInstance.showSheet(sheet: sheet, sender: UIButton(), owner: self)
    }
    func openPhotoGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            //            CommonClass.sharedInstance.ios15NavBar(color: .white, textColor: .blue)
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
//            imagePicker.navigationBar.isTranslucent = false
//            imagePicker.navigationBar.tintColor = .black
            //            self.present(imagePicker, animated: true, completion: nil)
         
            
            self.present(imagePicker, animated: true) {
                
                //                UINavigationBar.appearance(whenContainedInInstancesOf: [UIImagePickerController.self]).tintColor = .blue
            }
        }
    }
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("Button capture")
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true) {
            }
        }
    }
}

// MARK: -  Delegates

extension ClientAddEditViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.profileImageView.image = nil
//        self.profileImageView.image = UIImage(named: "user_new")
//        if self.viewModel.profilePicAttachment.id != "" {
//            self.viewModel.profilePicAttachment.isUpdated = true
//        }
        self.dismiss(animated: true, completion: { () -> Void in})
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.image = image
        }
//        self.dismiss(animated: true, completion: { () -> Void in})
        self.dismiss(animated: true) {
//            if let img = self.profileImageView.image {
//                let editor = FMImageEditorViewController(config: self.config, sourceImage: img)
//                editor.delegate = self
//                self.present(editor, animated: true)
//            }
        }
    }
}
extension ClientAddEditViewController: UITableViewDelegate ,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        9
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let profileSection = ProfileSections(rawValue: section) ?? ProfileSections.Phone
        if profileSection == .Birthday || profileSection == .Occupation || profileSection == .CompanyName || profileSection == .Position{
            return 0
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let indexPath = IndexPath.init(row: section, section: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileSectionCell", for: indexPath) as! ProfileSectionTableViewCell
        cell.privacyStackView.isHidden = false
        cell.titleLabel.text = self.viewModel.sections[section]
        
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let profileSection = ProfileSections(rawValue: section) ?? ProfileSections.Phone
        if profileSection == .Birthday || profileSection == .Occupation || profileSection == .CompanyName || profileSection == .Position{
            return nil
        }
        let indexPath = IndexPath.init(row: section, section: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileFooterCell", for: indexPath) as! ProfileFooterTableViewCell
        cell.addButton.setTitle(self.viewModel.footers[indexPath.row], for: .normal)
        
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let profileSection = ProfileSections(rawValue: section) ?? ProfileSections.Phone
        switch profileSection {
        case .Phone:
            return self.viewModel.model.phoneNumbers.count
        case .Email:
            return self.viewModel.model.emailAddress.count
        case .Social:
            return self.viewModel.model.socialProfile.count
        case .Birthday:
            return 1
        case .Address:
            return self.viewModel.addressTypes.count * self.viewModel.model.address.count
        case .Attachment:
            return self.viewModel.model.attachments.count
        case .Occupation:
            return self.viewModel.occupationValues.count
        case .CompanyName:
            return self.viewModel.companyValues.count
        case .Position:
            return self.viewModel.positionValues.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileEditCell", for: indexPath) as! EditProfileTableViewCell
        let profileSection = ProfileSections(rawValue: indexPath.section) ?? ProfileSections.Phone
        let addressCell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
//        cell.delegate = self
        cell.dropDownImageView.isHidden = false
        cell.typeLabelWidthConstraint.constant = 60
        cell.setIndexPath(indexPath: indexPath)
        switch profileSection {
        case .Phone:
            cell.bindData(model: self.viewModel.model.phoneNumbers[indexPath.row])
        case .Email:
            cell.bindData(model: self.viewModel.model.emailAddress[indexPath.row])
        case .Social:
            cell.bindData(model: self.viewModel.model.socialProfile[indexPath.row])
        case .Attachment:
            cell.bindData(model: self.viewModel.model.attachments[indexPath.row])
        case .Birthday:
            cell.typeLabelWidthConstraint.constant = 38
            cell.dropDownImageView.isHidden = true
            cell.bindData(model: "31 December,1992",type: profileSection)
        case .Address:
            addressCell.setIndexPath(indexPath: indexPath)
            addressCell.bindData(model: self.viewModel.model.address[indexPath.row])
            return addressCell
        case .Occupation:
            cell.bindData(model: self.viewModel.model.occupation,type: profileSection)
        case .CompanyName:
            cell.bindData(model: self.viewModel.model.companyName,type: profileSection)
        case .Position:
            cell.bindData(model: self.viewModel.model.position,type: profileSection)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let profileSection = ProfileSections(rawValue: indexPath.section) ?? ProfileSections.Phone

        if profileSection != .Address{
            CommonClass.sharedInstance.applyBorderOnTableViewSection(tableView, willDisplay: cell, forRowAt: indexPath)
        }else if profileSection == .Address && self.viewModel.model.address.count == 0 && self.contactVM.contact.address.count == 0{
            CommonClass.sharedInstance.applyBorderOnTableViewSection(tableView, willDisplay: cell, forRowAt: indexPath)
        }
    }
}

extension ClientAddEditViewController: FMImageEditorViewControllerDelegate{
    func fmImageEditorViewController(_ editor: FMImageEditorViewController, didFinishEdittingPhotoWith photo: UIImage) {
        self.dismiss(animated: true, completion: nil)
        self.viewModel.profilePicAttachment.isUpdated = true
        self.contactVM.profilePicAttachment.isUpdated = true
        self.profileImageView.image = photo
    }
}

extension ClientAddEditViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
