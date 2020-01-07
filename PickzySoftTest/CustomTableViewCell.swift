//
//  CustomTableViewCell.swift
//  PickzySoftTest
//
//  Created by Logesh on 31/12/17.
//  Copyright © 2017 Logesh. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var customTableImage: UIImageView!
    @IBOutlet weak var customTitle: UILabel!
    @IBOutlet weak var customBody: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
