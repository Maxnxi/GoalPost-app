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
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var completeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(goal: Goal) {
        self.goalDescription.text = goal.goalDesription
        self.typeOfGoal.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgres)
        
        if goal.goalProgres == goal.goalCompletionValue {
            self.completeView.isHidden = false
        } else {
            self.completeView.isHidden = true
        }
    }
}
