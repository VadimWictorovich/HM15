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
    }

    private func setupUI() {
        signInButton.isEnabled = false
        errorLabel.isHidden = true
    }
}
