//
//  GoalsViewController.swift
//  GoalPost-app
//
//  Created by Maksim Ponomarev on 03.11.2020.
//
import Foundation
import UIKit
import CoreData

class GoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let goal = Goal()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    setupView()
        
    }
    
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        print("Add Goal Btn was pressed.")
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        presentDetail(createGoalVC)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        
        cell.configureCell(description: "twice", type: .longTerm, goalProgressAmount: 3)
        
        return cell
    }
    

}
