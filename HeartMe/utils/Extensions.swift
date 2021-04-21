//
//  Extensions.swift
//  HeartMe
//
//  Created by Oran Even tzur on 21/04/2021.
//

import Foundation

extension String {
    func componentsSeparatedByString(separators: [String]) -> [String] {
        return separators.reduce([self]) { result, separator in
            return result.flatMap { ($0 as AnyObject).components(separatedBy: separator) }
        }
        .map { ($0 as AnyObject).trimmingCharacters(in: NSCharacterSet.whitespaces) }
    }
}


func extractCategoryWithName(name: String) -> TestCategory? {
    let words = name.componentsSeparatedByString(separators: [" ", ","])
    for word in words {
        switch word {
            case TestCategory.LDL.rawValue.lowercased():
                return TestCategory.LDL
            case TestCategory.HDL.rawValue.lowercased():
                return TestCategory.HDL
            case TestCategory.A1C.rawValue.lowercased():
                return TestCategory.A1C
            default:
                return TestCategory.UNKNOWN
        }
    }
    return nil
}


func enrichDataSet(bloodTestConfig: BloodTestConfig?) -> BloodTestConfig{
    let enrichedData = BloodTestConfig()
    if let config = bloodTestConfig {
        if let tests = config.bloodTestConfig {
            for test in tests {
                enrichedData.bloodTestConfig!.append(
                    BloodTest(
                        name: test.name,
                        threshold: test.threshold,
                        category: extractCategoryWithName(name: (test.name?.lowercased())!)
                    )
                )
            }
        }
        return enrichedData
    }
    return BloodTestConfig()
}
