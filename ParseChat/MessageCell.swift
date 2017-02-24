//
//  MessageCell.swift
//  ParseChat
//
//  Created by Sandeep Raghunandhan on 2/23/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    var content : String? {
        didSet {
            message.text = content
        }
    }
    @IBOutlet weak var message: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
