//
//  CreateNewAccVC.swift
//  HW15
//
//  Created by Вадим Игнатенко on 24.08.23.
//

import UIKit

final class CreateNewAccVC: UIViewController {
    @IBOutlet private var emailTF: UITextField!
    @IBOutlet private var errorEmailLabel: UILabel!
    @IBOutlet private var nameTF: UITextField!
    @IBOutlet private var passwordTF: UITextField!
    @IBOutlet private var errorPassLabel: UILabel!
    @IBOutlet private var strongPassIndicatorsViews: [UIView]!
    @IBOutlet private var confPassTF: UITextField!
    @IBOutlet private var errorConfPassLabel: UILabel!
    @IBOutlet private var continueButton: UIButton!
    @IBOutlet private var scrollView: UIScrollView!
    private var isValidEmail = false { didSet { updateContinueBtnState() } }
    private var isConfPass = false { didSet { updateContinueBtnState() } }
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueBtnState() } }
    private var iconClick = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    
    @IBAction private func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email)
        {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmailLabel.isHidden = isValidEmail
    }
    
    @IBAction private func passTFAction(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty
        {
            passwordStrength = VerificationService.isValidPassword(pass: passText)
        } else {
            passwordStrength = .veryWeak
        }
        errorPassLabel.isHidden = passwordStrength != .veryWeak
        setupStrongIndicatorsViews()
    }
    
    @IBAction private func confPassTFAction(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTF.text,
           !passText.isEmpty
        {
            isConfPass = VerificationService.isPassConf(pass1: passText, pass2: confPassText)
        } else {
            isConfPass = false
        }
        errorConfPassLabel.isHidden = isConfPass
    }
    
    @IBAction private func continueAction() {
        if let email = emailTF.text,
           let pass = passwordTF.text
        {
            let userModel = UserModel(name: nameTF.text, email: email, pass: pass)
            performSegue(withIdentifier: "gotoVerificationScreen", sender: userModel)
        }
    }
    
    @IBAction private func signInAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func iconAction1() {
        iconIsSecureTextEntry(TF: passwordTF)
    }
    
    @IBAction private func iconAction2() {
        iconIsSecureTextEntry(TF: confPassTF)
    }
    
    private func iconIsSecureTextEntry(TF: UITextField) {
        if iconClick {
            TF.isSecureTextEntry = false
        } else {
            TF.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    private func setupStrongIndicatorsViews() {
        strongPassIndicatorsViews.enumerated().forEach { index, view in
            if index <= passwordStrength.rawValue - 1 {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
    }
    
    private func updateContinueBtnState() {
        continueButton.isEnabled = isValidEmail && isConfPass && passwordStrength != .veryWeak
    }
    
    private func setupUI() {
        errorEmailLabel.isHidden = true
        errorPassLabel.isHidden = true
        errorConfPassLabel.isHidden = true
        continueButton.isEnabled = true
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let distVC = segue.destination as? VerificationsVC,
              let userModel = sender as? UserModel else { return }
        distVC.userModel = userModel
    }
}
