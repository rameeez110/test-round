//
//  ViewController.swift
//  TestRound
//
//  Created by Rameez Hasan on 28/03/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var viewModel: LoginViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

// MARK:- IBActions
extension ViewController {
    @IBAction func didTapRegister() {
        self.viewModel?.didTapRegister()
    }
    @IBAction func didTapLogin() {
        self.viewModel?.didTapLogin(email: self.emailTextField.text!,password: self.passwordTextField.text!)
    }
}

//MARK: - Delegates

extension ViewController: LoginViewModelDelegate {
    func alert(with title: String, message: String) {
        self.infoLabel.isHidden = false
        self.infoLabel.text = message
    }
    func validationError(error: String) {
        self.infoLabel.isHidden = false
        self.infoLabel.text = error
    }
}
