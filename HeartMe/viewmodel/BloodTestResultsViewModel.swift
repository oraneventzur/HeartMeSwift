//
//  BloodTestResultsViewModel.swift
//  HeartMe
//
//  Created by Oran Even tzur on 20/04/2021.
//

import Foundation


class BloodTestResultsViewModel {
    
    private let repository = BloodTestRepository()
    var bloodTests = Bindable<BloodTestConfig?>(BloodTestConfig())
    var currentTestCategory: TestCategory?
    var testResultsEvaluation = Bindable<BloodTestEvaluation?>(nil)
    
    init() {
        fetchBloodTestConfig()
    }
    
    func fetchBloodTestConfig(){
        repository.fetchBloodTestConfig(completion:  { (bloodTestConfig) in
            self.bloodTests.value = bloodTestConfig
        })
    }
    
    func onSubmitButtonClicked(
        name: String?,
        value: String?
    ) {
        if nil == name && nil == value {
            testResultsEvaluation.value = BloodTestEvaluation(
                result: Result.UNKNOWN, testName: nil, threshold: nil
            )
            return
        }
    
        let currentTest = extractBloodTestWithName(name: (name?.lowercased())!)
        testResultsEvaluation.value = evaluateTestResults(
            currentTest: currentTest, value: Int(value!) ?? 0
        )
    
    }
    
    private func extractBloodTestWithName(
        name: String
    ) -> BloodTest? {
        currentTestCategory = extractCategoryWithName(name: name)
        
        if let tests = bloodTests.value?.bloodTestConfig {
            if let category = currentTestCategory {
                for bloodTest in tests {
                    if bloodTest.category == category {
                        return bloodTest
                    }
                }
            }
        }
       return nil
    }
    
    
    private func evaluateTestResults(
        currentTest: BloodTest?,
        value: Int
    ) -> BloodTestEvaluation {
        if nil == currentTest {
            return BloodTestEvaluation(result: Result.UNKNOWN, testName: nil, threshold: nil)
        }
        
        switch currentTest?.threshold {
            case _ where (currentTest?.threshold)! < value:
                return BloodTestEvaluation(result: Result.BAD, testName: currentTest?.name, threshold: currentTest?.threshold)
            case _ where (currentTest?.threshold)! >= value:
                return BloodTestEvaluation(result: Result.GOOD, testName: currentTest?.name, threshold: currentTest?.threshold)
            default:
                return BloodTestEvaluation(result: Result.UNKNOWN, testName: currentTest?.name, threshold: currentTest?.threshold)
        }
    }
}


