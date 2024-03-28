//
//  MealListTableViewCell.swift
//  Receipies
//
//  Created by Apple on 27/03/24.
//

import UIKit

class MealListTableViewCell: UITableViewCell {
    @IBOutlet weak var imageMeal: UIImageView!
    
    @IBOutlet weak var mealName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
