//
//  ViewController.swift
//  HeartMe
//
//  Created by Oran Even tzur on 20/04/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var screenTitleLb: UILabel!
    @IBOutlet weak var onBoardingMessageLb: UILabel!
    @IBOutlet weak var userInputTestNameTf: UITextField!
    @IBOutlet weak var userInputTestResValueTf: UITextField!
    @IBOutlet weak var testResultsEvaluationLb: UILabel!
    
    var bloodTestViewModel: BloodTestResultsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        bindData()
    }

    func initViewModel(){
        bloodTestViewModel = BloodTestResultsViewModel()
    }
    
    func bindData(){
        bloodTestViewModel.bloodTests.bind{ [unowned self] in
            if nil == $0 {
                self.disableUIElements()
                self.presentOfflineMessage()
            }
        }
        
        bloodTestViewModel.testResultsEvaluation.bind{ [unowned self] in
            self.presentTestEvaluationResults(bloodTestEvaluation: $0)
        }
    }

    
    @IBAction func onSubmitButtonClicked(_ sender: UIButton) {
        if nil == userInputTestNameTf.text || nil == userInputTestResValueTf.text  {
            return
        }
        bloodTestViewModel.onSubmitButtonClicked(
            name: userInputTestNameTf.text,
            value: userInputTestResValueTf.text
        )
    }
    
    func presentTestEvaluationResults(bloodTestEvaluation: BloodTestEvaluation?){
        if let evaluation = bloodTestEvaluation {
            if evaluation.result == Result.UNKNOWN {
                testResultsEvaluationLb.text = "\(evaluation.result.rawValue) test name, please check your input and try again"
            }else {
                testResultsEvaluationLb.text = "\(evaluation.result.rawValue) for \(evaluation.testName!)"
            }
        }
    }
    
    func disableUIElements(){
        userInputTestResValueTf.isUserInteractionEnabled = false
        userInputTestNameTf.isUserInteractionEnabled = false
    }
    
    func presentOfflineMessage(){
        screenTitleLb.text = "Oops, you are offline."
        onBoardingMessageLb.text = "Please check your internet connection and try again"
    }
}

