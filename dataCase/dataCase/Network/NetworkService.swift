//
//  NetworkService.swift
//  dataCase
//
//  Created by Toygun Çil on 28.10.2022.
//

import Foundation

class NetworkService {
    
    static let sharetNetwork = NetworkService()
    private init() {}
    
    var responseData: ResponseData?
    
    func parseJSON() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            responseData = try JSONDecoder().decode(ResponseData.self, from: jsonData)
        } catch{
            print("error: \(error)")
        }
        
    }
}
