//
//  CreateGoalVC.swift
//  GoalPost-app
//
//  Created by Maksim Ponomarev on 03.11.2020.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var goalDescriptionTxtField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
    }
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
    }
    

}
