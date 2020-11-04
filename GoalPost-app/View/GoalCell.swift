//
//  GoalCell.swift
//  GoalPost-app
//
//  Created by Maksim Ponomarev on 03.11.2020.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescription: UILabel!
    @IBOutlet weak var typeOfGoal: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(description:String, type:GoalType, goalProgressAmount: Int) {
        self.goalDescription.text = description
        self.typeOfGoal.text = type.rawValue
        self.goalProgressLbl.text = String(describing: goalProgressAmount)
        
    }
    
}
