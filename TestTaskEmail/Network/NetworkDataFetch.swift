//
//  NetworkDataFetch.swift
//  TestTaskEmail
//
//  Created by Максим Пасюта on 31.03.2022.
//

import Foundation


class NetworkDataFetch {
    
    static let shader = NetworkDataFetch()
    private init(){}
    
    func fetchmail(verifiableMail: String, response: @escaping (MailResponseModel?, Error?) -> Void){
        NetworkRequest.shader.requestData(verifiableMail: verifiableMail) { result in
            
            switch result{
            case .success(let data):
                do {
                    let mail = try JSONDecoder().decode(MailResponseModel.self, from: data)
                    response(mail, nil)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            case .failure(let error):
                print("Error received \(error.localizedDescription )")
                response(nil, error)
            }
        }
    }
}
