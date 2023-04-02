//
//  FeedViewController.swift
//  OrnekFirebaseProjesi
//
//  Created by Emre Keseroğlu on 26.03.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseCore
import FirebaseStorage
import SDWebImage
import MapKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var postDizisi = [Post]()



    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        FirebaseVerileriAl()
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.estimatedRowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(FirebaseVerileriAl), name: NSNotification.Name(rawValue: "yeniPost"), object: nil)

    }
    
    @objc func FirebaseVerileriAl() {
        let firebaseDatabase = Firestore.firestore()
        firebaseDatabase.collection("Post").addSnapshotListener({ snapshot, error in
            if error != nil{
                self.hataMesajıGoster(title: "Hata", message: error?.localizedDescription ?? "Hata aldınız")
            }else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.postDizisi.removeAll(keepingCapacity: false)

                    for document in snapshot!.documents {
                        if let gorselUrl = document.get("gorselUrl") as? String {
                            if let email = document.get("email") as? String {
                                
                                if let yorum = document.get("yorum") as? String {
                                    let post = Post(kullanicimail: email, kullaniciYorum: yorum, kullaniciGorsel: gorselUrl)
                                    self.postDizisi.append(post)
                                }
                            }
                        }
                    }
                    self.feedTableView.reloadData()
                }
            }
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.emailTextField.text = postDizisi[indexPath.row].kullanicimail
        cell.yorumTextField.text = postDizisi[indexPath.row].kullaniciYorum
        cell.feedImageView.sd_setImage(with: URL(string: self.postDizisi[indexPath.row].kullaniciGorsel))
        return cell
    }

    func hataMesajıGoster(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
