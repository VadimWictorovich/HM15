//
//  WelcomeVC.swift
//  HW15
//
//  Created by Вадим Игнатенко on 29.08.23.
//

import UIKit

final class WelcomeVC: UIViewController {
    var userModel: UserModel?

    @IBOutlet private var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction private func continueAction() {
        guard let userModel = userModel else { return }
        UserDefaultsService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        infoLabel.text = "\(userModel?.name ?? userModel?.email ?? "") to our Cool App"
    }
}
