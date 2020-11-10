//
//  DeletedGoal.swift
//  GoalPost-app
//
//  Created by Maksim Ponomarev on 06.11.2020.
//

//import Foundation
//
////Deleted data
//class DeletedGoal {
//    
//    var deletedGoalDescription:String!
//    var deletedGoalType: GoalType!
//    var deletedGoalCompletionValue: Int32!
//    var deletedGoalProgress: Int32!
//    
//    func initData(goalDescription description: String, type:GoalType, completionValue: Int32, progress: Int32) {
//        self.deletedGoalDescription = description
//        self.deletedGoalType = type
//        self.deletedGoalCompletionValue = type
//        self.deletedGoalProgress = progress
//    }
//    
//    func saveDeletedData(completion: (_ finished: Bool) -> ()) {
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
//        let deletedGoal = DeletedGoal(context: managedContext)
//        
//        deletedGoal.goalDesription = deletedGoalDescription
//        deletedGoal.goalType = deletedGoalType
//        deletedGoal.goalCompletionValue = deletedGoalCompletionValue
//        deletedGoal.goalProgres = deletedGoalProgress
//        do{
//       try managedContext.save()
//            print("Successfully saved deleted data.")
//            completion(true)
//        } catch {
//            debugPrint("Could not save: \(error.localizedDescription)")
//            completion(false)
//        }
//    }
//}
