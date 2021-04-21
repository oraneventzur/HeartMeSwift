//
//  ServiceApi.swift
//  HeartMe
//
//  Created by Oran Even tzur on 20/04/2021.
//

import Foundation

class APIService : NSObject {
    
    private let sourcesURL = URL(string: "https://s3.amazonaws.com/s3.helloheart.home.assignment/bloodTestConfig.json")!
    
    func fetchBloodTestConfig(completion : @escaping (BloodTestConfig) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                if let data = data {
                    
                    let jsonDecoder = JSONDecoder()
                    
                    var config = try! jsonDecoder.decode(BloodTestConfig.self, from: data)
                    config = enrichDataSet(bloodTestConfig: config)
                    completion(config)
                }
            }
            
        }.resume()
    }
}
