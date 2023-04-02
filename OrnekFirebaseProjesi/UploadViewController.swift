//
//  UploadViewController.swift
//  OrnekFirebaseProjesi
//
//  Created by Emre Keseroğlu on 26.03.2023.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var yorumTextField: UITextField!
    
    @IBOutlet weak var kaydetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(imageGestureRecognizer)
        kaydetButton.isEnabled = false
        
    }
    @objc func gorselSec() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        dismiss(animated: true)
        kaydetButton.isEnabled = true
        
        
    }
    
    
    @IBAction func kaydetButtonTiklandi(_ sender: Any) {
        
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
           imageReference.putData(data, metadata: nil) { storagemetadata, error in
                if error != nil {
                    self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "Hata Aldınız")
                }else {
                        
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            if let imageUrl = imageUrl {
                            
                                let firestoreDatabase = Firestore.firestore()
                                
                                let firestorePost = ["gorselUrl" : imageUrl, "yorum" : self.yorumTextField.text, "email" : Auth.auth().currentUser?.email, "tarih" : FieldValue.serverTimestamp() ] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { error in
                                    if error != nil {
                                        self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "Hata Aldınız")
                                    }else{
                                        
                                        self.tabBarController?.selectedIndex = 0
                                        self.imageView.image = UIImage(named: "67832")
                                        self.yorumTextField.text = ""
                                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "yeniPost"), object: nil)

                                    }
                                }
                               
                            }
                            
                            
                        }
                    }
                }
            }
        }
   }
    
    func hataMesaji (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }

        
    }

