//
//  ProfileVC.swift
//  HW15
//
//  Created by Вадим Игнатенко on 30.08.23.
//

import UIKit

final class ProfileVC: UIViewController {
    
    @IBOutlet weak var labelOut: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelOut.text = UserDefaultsService.setUserModel()?.email
    }
    
    
    @IBAction private func changeAccAction() {
        performSegue(withIdentifier: "goToChange", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChange",
           let changeVC = segue.destination as? ChangeUserAccVC {
            changeVC.profileVC = self
        }
    }
    
    @IBAction private func deleteAction() {
        UserDefaultsService.cleanUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func logOutAction() {
        navigationController?.popToRootViewController(animated: true)
    }
}
