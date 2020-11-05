//
//  CreateGoalVC.swift
//  GoalPost-app
//
//  Created by Maksim Ponomarev on 03.11.2020.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var goalDescriptionTxtField: UITextView!
    
    var goalType: GoalType = .shortTerm
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    func setupView() {
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        goalDescriptionTxtField.delegate = self
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
        
    }
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        print("next Button was pressed and do some magic!\n")
        if goalDescriptionTxtField.text != "" && goalDescriptionTxtField.text != "What is your Goal?" {
            
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinisgGoalVC") as? FinischCreateGoalVC else {return}
            
//            guard let finishGoalViewC = storyboard?.instantiateViewController(withIdentifier: "FinisgGoalVC") as? FinischCreateGoalVC else {return}
          finishGoalVC.initData(description: goalDescriptionTxtField.text!, goalType: goalType)
//            finishGoalViewC.initData(description: goalDescriptionTxtField.text!, goalType: goalType)
//
           // guard let window = CreateGoalVC().view.window else {return}
            
           // finishGoalViewC.view.window = window
            
            //present(finishGoalViewC, animated: true, completion: nil)
            
            //presentDetail(finishGoalVC)
            //finishGoalVC.performsActionsWhilePresentingModally = true
            
            //finishGoalVC.modalPresentationStyle = .fullScreen
           
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalDescriptionTxtField.text = ""
        goalDescriptionTxtField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    

}
