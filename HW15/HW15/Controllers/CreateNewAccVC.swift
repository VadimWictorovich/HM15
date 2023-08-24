//
//  CreateNewAccVC.swift
//  HW15
//
//  Created by Вадим Игнатенко on 24.08.23.
//

import UIKit

class CreateNewAccVC: UIViewController {
    
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var errorEmailLabel: UILabel!
    @IBOutlet private weak var nameTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var errorPassLabel: UILabel!
    @IBOutlet private var strongPassIndicatorsViews: [UIView]!
    @IBOutlet private weak var confPassTF: UITextField!
    @IBOutlet private weak var errorConfPassLabel: UILabel!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI ()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    
    private func setupUI () {
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
}
