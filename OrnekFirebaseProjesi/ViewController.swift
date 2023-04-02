//
//  ViewController.swift
//  OrnekFirebaseProjesi
//
//  Created by Emre Keseroğlu on 26.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class ViewController: UIViewController {

    @IBOutlet weak var sifreTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapTiklandi(_ sender: Any) {
        if emailTextField.text != "" && sifreTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextField.text!) { authResult, error in
                if error != nil {
                    self.hataMesaji(title: "Hata",message: error?.localizedDescription ?? "Hatalı giriş yaptınız")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)

                }
            }
        }
        
        
        
    }
    
    
    @IBAction func kayitOlTiklandi(_ sender: Any) {
        
        
        if emailTextField.text != "" && sifreTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: sifreTextField.text!) { authResult, error in
                if error != nil {
                    self.hataMesaji(title: "Hata",message: error?.localizedDescription ?? "Hatalı giriş yaptınız")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
    }
                        func hataMesaji(title: String, message: String) {
                            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                            alert.addAction(okButton)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
}

