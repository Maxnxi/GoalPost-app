//
//  FinischCreateGoalVC.swift
//  GoalPost-app
//
//  Created by Maksim Ponomarev on 04.11.2020.
//

import UIKit
import CoreData

class FinischCreateGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pointsToComplete: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    
    var goalDescription: String!
    var goalType:GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        createBtn.bindToKeyboard()
        pointsToComplete.delegate = self
    }
    
    func initData(description: String, goalType: GoalType) {
        self.goalDescription = description
        self.goalType = goalType
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pointsToComplete.text = ""
        pointsToComplete.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }

    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
            if pointsToComplete.text != "" {
            print("create goal Btn Was Pressed!")
            self.saveData { (complete) in
                if complete{
                    dismissDetail()
                }
            }
        }
    }
    
    func saveData(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContext)
        
        goal.goalDesription = goalDescription
        goal.goalType = goalType?.rawValue
        goal.goalCompletionValue = Int32(pointsToComplete.text!)!
        goal.goalProgres = Int32(0)
        
        do{
       try managedContext.save()
            print("Successfully saved data.")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }

}
