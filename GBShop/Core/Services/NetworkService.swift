//
//  NetworkService.swift
//  VKApp
//
//  Created by Denis Kuzmin on 24.05.2021.
//

import UIKit

class NetworkService {
    private let session = URLSession.shared
 
    func getData(from url: String, completionBlock: @escaping (Data) -> Void) {
        guard let url = URL(string: url)
        else {
            print("NetworkService error: Invalid url")
            return
        }
        
        var request = URLRequest(url: url,timeoutInterval: 5.0)
        request.addValue("Mozilla/5.0", forHTTPHeaderField: "User-Agent")

        request.httpMethod = "GET"
        
        DispatchQueue.global().async {
            let task = self.session.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("NetworkService error: \(String(describing: error))")
                    print("URL: \(url)")
                    return
                }
                guard let data = data
                else {
                    print("NetworkService error: No data")
                    return
                }
                DispatchQueue.main.async {
                    completionBlock(data)
                }
            }
            task.resume()
        }
    }
    
}
