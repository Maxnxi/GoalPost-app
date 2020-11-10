//
//  GoalsViewController.swift
//  GoalPost-app
//
//  Created by Maksim Ponomarev on 03.11.2020.
//
import Foundation
import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var goals: [Goal] = []
    var deletedGoalDescription: String!
    var deletedGoalType: String!
    var deletedGoalProgress: Int32!
    var deletedGoalComplitionValue:Int32!

    // OUTLETS
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var unDeleteView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear works")
        fetchCoreeDataObjects()
        unDeleteView.isHidden = true
        tableView.reloadData()
    }
    
    func fetchCoreeDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                    //tableView.reloadData()
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }

    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        spinner.isHidden = true
        unDeleteView.isHidden = true
        
        let closetouch = UITapGestureRecognizer(target: self, action: #selector(GoalsViewController.closeTap(_:)))
        tableView.addGestureRecognizer(closetouch )
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        unDeleteView.isHidden = true
    }

    // IBACTIONS
    
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        print("Add Goal Btn was pressed.")
       guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        presentDetail(createGoalVC)
    }
    
    @IBAction func unDeleteBtnWasPressed(_ sender: Any) {
        
        saveDeletedData { (complete) in
            if complete {
                unDeleteView.isHidden = true
            }
        }
    }
    
    func saveDeletedData(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let uNgoal = Goal(context: managedContext)
        uNgoal.goalDesription = deletedGoalDescription
        uNgoal.goalType = deletedGoalType
        uNgoal.goalProgres = deletedGoalProgress
        uNgoal.goalCompletionValue = deletedGoalComplitionValue
        
        print("\n\n\n Deleted goal was: \(String(describing: uNgoal.goalDesription))")
        do{
       try managedContext.save()
            print("Successfully saved back Deleted data.")
                        completion(true)
            fetchCoreeDataObjects()
            tableView.reloadData()
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    // TABLEVIEW property
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    //NEED TO UPDATE THIS FUNCTION! deprecated
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
            
                self.removeGoal(atIndexPath: indexPath)
                self.fetchCoreeDataObjects()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                print("Successfully Deleted goal")
            
          })
          deleteAction.backgroundColor = .red
        let addProgressAction = UIContextualAction(style: .normal, title: "Add +1") { (action, view, success) in
            self.setProgressForGoal(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            print("\n Successfully add progress to goal: \(String(describing: self.goals[indexPath.row].goalDesription))")
            
            let alert  = UIAlertController(title: "Done! ", message: "Progress added" ,preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK ", style: .default, handler: nil)
                    alert.addAction(okAction)
                    alert.popoverPresentationController?.sourceView = self.view //
                    self.present(alert, animated: true, completion: nil)
        }
        deleteAction.image = UIImage(named: "Trash")
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        addProgressAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
          return UISwipeActionsConfiguration(actions: [deleteAction, addProgressAction])
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("begin draging")
        spinner.isHidden = false
        spinner.startAnimating()
        tableView.reloadData()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("stop draging")
        spinner.isHidden = true
        spinner.stopAnimating()
        unDeleteView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        tableView.reloadData()
        return true
    }
}

// EXTENSION
extension GoalsViewController {
    
    func fetch(completion:(_ complete: Bool ) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("Succesfully fetch from DB")
            completion(true)
        } catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let goalToDelete:Goal = goals[indexPath.row]
        
        deletedGoalDescription = goalToDelete.goalDesription
        deletedGoalType = goalToDelete.goalType
        deletedGoalProgress = goalToDelete.goalProgres
        deletedGoalComplitionValue = goalToDelete.goalCompletionValue
        //deletedGoalType = goalToDelete.goalType
        //deletedGoal = goalToDelete
        print("\n\nto delete: \(String(describing: deletedGoalDescription))")
        unDeleteView.isHidden = false
        
        managedContext.delete(goals[indexPath.row])
        do {
            try managedContext.save()
            print("Successfuly removed Goal.\n")
        } catch {
            debugPrint("\nCould not remove \(error.localizedDescription)")
        }
    }
    
    func setProgressForGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgres < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgres = chosenGoal.goalProgres + 1
        } else {
            return
        }
        do {
            try managedContext.save()
            print("Successfully set progress!")
        } catch{
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
}
