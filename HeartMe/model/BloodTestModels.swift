//
//  BloodTestModels.swift
//  HeartMe
//
//  Created by Oran Even tzur on 20/04/2021.
//

import Foundation

struct BloodTest : Decodable{
    var name: String?
    var threshold: Int?
    var category: TestCategory?
}

class BloodTestConfig : Decodable {
    var bloodTestConfig: [BloodTest]?
    init() {
        bloodTestConfig = []
    }
}

struct BloodTestEvaluation {
    var result: Result
    var testName: String?
    var threshold: Int?
}

enum Result : String {
    case GOOD = "GOOD"
    case BAD = "BAD"
    case UNKNOWN = "UNKNOWN"
}

enum TestCategory: String, Decodable{
    case HDL = "hdl"
    case LDL = "ldl"
    case A1C = "a1c"
    case UNKNOWN = "unknown"
}
