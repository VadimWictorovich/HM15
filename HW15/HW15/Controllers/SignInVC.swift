//
//  SignInVC.swift
//  HW15
//
//  Created by Вадим Игнатенко on 24.08.23.
//

import UIKit

final class SignInVC: UIViewController {
    
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var passTF: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        signInButton.isEnabled = false
        errorLabel.isHidden = true
    }
}
