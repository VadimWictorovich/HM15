//
//  VerificationsVC.swift
//  HW15
//
//  Created by Вадим Игнатенко on 29.08.23.
//

import UIKit

final class VerificationsVC: UIViewController {
    private var randomInt = Int.random(in: 10000 ... 99999)
    private var sleepTime = 3
    var userModel: UserModel?
    @IBOutlet private var infpLabel: UILabel!
    @IBOutlet private var codeTF: UITextField!
    @IBOutlet private var errorCodeLabel: UILabel!
    @IBOutlet private var cenretConsrtaint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        cenretConsrtaint.constant -= keyboardSize.height / 2
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        cenretConsrtaint.constant += keyboardSize.height / 2
    }
    
    private func setupUI() {
        infpLabel.text = "Please enter code '\(randomInt)' from \(userModel?.email ?? "")"
    }
    
    @IBAction private func codeTFAction(_ sender: UITextField) {
        errorCodeLabel.isHidden = true
        guard let text = sender.text,
              !text.isEmpty,
              text == randomInt.description
        else {
            errorCodeLabel.isHidden = false
            sender.isUserInteractionEnabled = false
            errorCodeLabel.text = "Error code. Please wait \(sleepTime) seconds"
            let dispathAfter = DispatchTimeInterval.seconds(sleepTime)
            let deadline = DispatchTime.now() + dispathAfter
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                sender.isUserInteractionEnabled = true
                self.errorCodeLabel.isHidden = true
                self.sleepTime *= 2
            }
            return
        }
        performSegue(withIdentifier: "goToWelcomeScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let distVC = segue.destination as? WelcomeVC else { return }
        distVC.userModel = userModel
    }
}
