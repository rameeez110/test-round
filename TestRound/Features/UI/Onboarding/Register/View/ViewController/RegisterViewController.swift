//
//  RegisterViewController.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

class RegisterViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var viewModel: RegisterViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - IBActions
extension RegisterViewController {
    @IBAction func didTapRegister() {
        self.viewModel?.didTapRegister(email: self.emailTextField.text!, password: self.passwordTextField.text!, confirmPassword: self.confirmPasswordTextField.text!)
    }
    @IBAction func didTapLogin() {
        self.viewModel?.didTapLogin()
    }
}

//MARK: - Delegates

extension RegisterViewController: RegisterViewModelDelegate {
    func alert(with title: String, message: String) {
        self.infoLabel.isHidden = false
        self.infoLabel.text = message
    }
    func validationError(error: String) {
        self.infoLabel.isHidden = false
        self.infoLabel.text = error
    }
}

