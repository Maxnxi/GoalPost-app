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

    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //let goal = Goal()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    setupView()
        //tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
//        var indexSet = IndexSet()
//
//        tableView.reloadSections(, with: .automatic)
        
        fetchCoreeDataObjects()
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
//    override func viewWillLayoutSubviews() {
//        print("viewWillLayoutSubviews works")
//        tableView.reloadData()
//
//    }
    
//    override func loadView() {
//        print("loadView works")
//        tableView.reloadData()
//    }
    
//    override func show(_ vc: UIViewController, sender: Any?) {
//        print("show works")
//        tableView.reloadData()
//    }
    
    
    
    func setupView(){
        
        tableView.delegate = self
        tableView.dataSource = self
       // tableView.isHidden = false
    }
    

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        print("Add Goal Btn was pressed.")
       guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        
        presentDetail(createGoalVC)
        //createGoalVC.modalTransitionStyle = .flipHorizontal
        //createGoalVC.modalPresentationStyle = .fullScreen
        //present(createGoalVC, animated: true, completion: nil)
    }
    
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
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreeDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgressForGoal(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
    return [deleteAction, addAction]
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("begin draging")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
let sureToDelete = "to delete?"
        return sureToDelete
    }
    
    func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        tableView.reloadData()
        return true
    }
    
}

extension GoalsViewController {
    func fetch(completion:(_ complete: Bool ) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
       // let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("Succesfully fetch from DB")
           // tableView.reloadData()
            completion(true)
        } catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
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
