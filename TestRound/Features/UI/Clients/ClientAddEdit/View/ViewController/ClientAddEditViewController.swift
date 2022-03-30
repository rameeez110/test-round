//
//  ClientAddEditViewController.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit
import FMPhotoPicker

class ClientAddEditViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var viewModel: ClientAddEditViewModelProtocol?
    var config = FMPhotoPickerConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
        self.viewModel?.mapUIDataSource()
    }
}

// MARK: -  Methods
extension ClientAddEditViewController {
    func setupUI() {
        // this config will pick only images
        // videos are not accepted
        self.config.mediaTypes = [.image]
        self.registerNibsAndSetupTableView()
        self.firstNameTextField.autocapitalizationType = .words
        self.lastNameTextField.autocapitalizationType = .words
    }
    // This method is responsible for registring cells and setup configurations for table view
    func registerNibsAndSetupTableView(){
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.tableFooterView = UIView()
        
        let nibName = UINib(nibName: "EditClientTableViewCell", bundle:nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "clientEditCell")
        let footerNib = UINib(nibName: "ClientFooterTableViewCell", bundle:nil)
        self.tableView.register(footerNib, forCellReuseIdentifier: "clientFooterCell")
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
    }
    // Use this method for add and update
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
        self.showSheet(sheet: sheet, sender: UIButton(), owner: self)
    }
    func openPhotoGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true) {
            }
        }
    }
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true) {
            }
        }
    }
    // Open Native Action Sheet
    func showSheet(sheet: UIAlertController, sender: UIView, owner: UIViewController) {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            owner.present(sheet, animated: true, completion: nil)
        case .pad:
            let popOver = sheet.popoverPresentationController
            
            popOver?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popOver?.sourceView = sender
            popOver?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            
            owner.present(sheet, animated: true, completion: nil)
        case .unspecified:
            owner.present(sheet, animated: true, completion: nil)
        default:
            print("")
        }
        
    }
}

// MARK: -  Delegates

extension ClientAddEditViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: { () -> Void in})
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.image = image
        }
        self.dismiss(animated: true) {
            if let img = self.profileImageView.image {
                let editor = FMImageEditorViewController(config: self.config, sourceImage: img)
                editor.delegate = self
                self.present(editor, animated: true)
            }
        }
    }
}
extension ClientAddEditViewController: UITableViewDelegate ,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 6{
            return 40
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height - 10)
        let type = ClientSections(rawValue: section) ?? .PersonalId
        label.text = CommonClass.sharedInstance.getSectionHeader(sectionType: type)
        label.font = UIFont(.avenirDemiBold, size: .standard(.h5))
        label.textColor = .black
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 6{
            let indexPath = IndexPath.init(row: section, section: 0)
            let cell = tableView.dequeueReusableCell(withIdentifier: "clientFooterCell", for: indexPath) as! ClientFooterTableViewCell
            cell.addButton.setTitle("Add Account", for: .normal)
            return cell.contentView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 6 {
//            return self.viewModel?.client.accounts.count
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = ClientSections(rawValue: indexPath.section) ?? .PersonalId
        if sectionType == .Address {
            let addressCell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
            return addressCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "clientEditCell", for: indexPath) as! EditClientTableViewCell
            cell.setIndexPath(indexPath: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ClientAddEditViewController: FMImageEditorViewControllerDelegate{
    func fmImageEditorViewController(_ editor: FMImageEditorViewController, didFinishEdittingPhotoWith photo: UIImage) {
        self.dismiss(animated: true, completion: nil)
        self.profileImageView.image = photo
    }
}

extension ClientAddEditViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
