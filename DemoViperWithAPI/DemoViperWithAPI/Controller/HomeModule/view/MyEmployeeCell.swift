//
//  MyEmployeeCell.swift
//  TOYIN
//
//  Created by Mehul Parmar on 06/04/19.
//  Copyright © 2018 TOYIN. All rights reserved.
//  LinkedIn: https://www.linkedin.com/in/mehul-p-20268539/

import UIKit

class MyEmployeeCell: UITableViewCell {

    @IBOutlet weak var lblRatingBig: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblWorkingTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
