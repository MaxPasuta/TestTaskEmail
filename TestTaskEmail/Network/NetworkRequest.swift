//
//  NetworkRequest.swift
//  TestTaskEmail
//
//  Created by Максим Пасюта on 31.03.2022.
//

import Foundation


class NetworkRequest{
    
    static let shader = NetworkRequest()
    private init(){}
    
    func requestData(verifiableMail: String, complition:@escaping(Result<Data,Error>) -> Void){
        
        let url = "https://api.kickbox.com/v2/verify?email=\(verifiableMail)&apikey=\(apiKey)"
        
        guard let urlString = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    complition(.failure(error))
                    return
                }
                guard let data = data else {return}
                complition(.success(data))

            }
        }.resume()
    }
}
