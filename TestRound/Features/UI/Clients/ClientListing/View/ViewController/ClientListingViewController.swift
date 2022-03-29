//
//  ClientListingViewController.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit
import SwipeCellKit

class ClientListingViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!

    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        self.setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.refreshControl.endRefreshing()
    }
}

// MARK: -  Methods
extension ClientListingViewController {
    // MARK: - Action handlers
    @IBAction func didTapAdd() {
        
    }
    
    @objc func refreshData(_ sender: AnyObject) {
       // Code to refresh table view
    }
    
    func setupUI() {
        self.registerNibsAndSetupTableView()
    }
    func registerNibsAndSetupTableView(){
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.tableFooterView = UIView()
        
        let nibName = UINib(nibName: "ClientsListingTableViewCell", bundle:nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "ClientsListingTableViewCell")
        
        self.tableView.estimatedRowHeight = 58
        
        let dummyViewHeight = CGFloat(0)
        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
}

// MARK: - Actions
extension ClientListingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
}

extension ClientListingViewController: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientsListingTableViewCell", for: indexPath) as! ClientsListingTableViewCell
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
            return false
        }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}

extension ClientListingViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if orientation == .right{
            
            let deleteAction = SwipeAction(style: .destructive, title: "delete"){ action, indexPath in
                print("delete pressed")
            }
            return [deleteAction]
        }
        
        return nil
    }
}

// Image picking gallery
//extension ContactsViewController: SwiftPhotoGalleryDataSource,SwiftPhotoGalleryDelegate {
//    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
//        return 1
//    }
//
//    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
//        if let image = self.detailImage {
//            return image
//        }
//        return UIImage()
//    }
//
//    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
//        dismiss(animated: true, completion: nil)
//    }
//}

