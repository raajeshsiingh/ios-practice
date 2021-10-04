//
//  TableViewCell.swift
//  Assignment6Rajesh
//
//  Created by Admin on 29/07/21.
//

import UIKit

protocol optionButton {
   func optionButtonTapped(cell: TableViewCell)
}


class TableViewCell: UITableViewCell {

    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var cellAddress: UILabel!
    @IBOutlet weak var cellDOB: UILabel!
    @IBOutlet weak var cellFullName: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!

    var delegate: optionButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        cellImageView.layer.borderWidth = 1
        cellImageView.layer.masksToBounds = false
        cellImageView.layer.borderColor = UIColor.black.cgColor
        cellImageView.layer.cornerRadius = cellImageView.frame.height/2
        cellImageView.clipsToBounds = true
    }
    
    @IBAction func optionButtonTap(_ sender: Any) {
        delegate?.optionButtonTapped(cell: self)
    }
}
