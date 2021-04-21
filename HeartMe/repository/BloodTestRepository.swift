//
//  BloodTestRepository.swift
//  HeartMe
//
//  Created by Oran Even tzur on 20/04/2021.
//

import Foundation

public class BloodTestRepository {
    
    private let api = APIService()
    
    func fetchBloodTestConfig(
        completion : @escaping (BloodTestConfig) -> ()
    ) -> Void {
        return api.fetchBloodTestConfig(completion: completion)
    }

}

