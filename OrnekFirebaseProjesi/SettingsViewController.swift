//
//  SettingsViewController.swift
//  OrnekFirebaseProjesi
//
//  Created by Emre Keseroğlu on 26.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CikisYapTiklandi(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toVC", sender: nil)
        }catch {
            print ("Hata")
        }
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
