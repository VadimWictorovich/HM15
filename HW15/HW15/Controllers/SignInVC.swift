//
//  SignInVC.swift
//  HW15
//
//  Created by Вадим Игнатенко on 24.08.23.
//

import UIKit

final class SignInVC: UIViewController {
    @IBOutlet private var emailTF: UITextField!
    @IBOutlet private var passTF: UITextField!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        if let _ = UserDefaultsService.setUserModel() { goToTBC() }
    }

    override func viewWillDisappear(_ animated: Bool) {
        emailTF.text = ""
        passTF.text = ""
    }
    
    @IBAction private func signInAction() {
        errorLabel.isHidden = true
        guard
            let email = emailTF.text,
            let pass = passTF.text,
            let userModel = UserDefaultsService.setUserModel(),
            email == userModel.email,
            pass == userModel.pass
        else {
            errorLabel.isHidden = false
            return
        }
        goToTBC()
    }
    
    private func setupUI() {
        //signInButton.isEnabled = false
        errorLabel.isHidden = true
    }
    
    private func goToTBC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
