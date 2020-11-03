//
//  GoalsViewController.swift
//  GoalPost-app
//
//  Created by Maksim Ponomarev on 03.11.2020.
//

import UIKit

class GoalsViewController: UIViewController {

    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        print("Add Goal Btn was pressed.")
    }
    

}
