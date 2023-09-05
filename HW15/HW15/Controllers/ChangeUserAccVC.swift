//
//  ChangeUserAccVC.swift
//  HW15
//
//  Created by Вадим Игнатенко on 30.08.23.
//

import UIKit

final class ChangeUserAccVC: UIViewController {
    weak var profileVC: ProfileVC?
    @IBOutlet private weak var nameTF: UITextField!
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var passTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction private func saveAction(_ sender: UIButton) {
        UserDefaultsService.changeUserModel(name: nameTF.text, email: emailTF.text, password: passTF.text)
        profileVC?.labelOut.text = UserDefaultsService.setUserModel()?.email
        dismiss(animated: true)
    }
}
