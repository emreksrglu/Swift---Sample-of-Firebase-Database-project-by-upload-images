//
//  FeedTableViewCell.swift
//  OrnekFirebaseProjesi
//
//  Created by Emre Keseroğlu on 27.03.2023.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var emailTextField: UILabel!
    
    @IBOutlet weak var yorumTextField: UILabel!
    
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
