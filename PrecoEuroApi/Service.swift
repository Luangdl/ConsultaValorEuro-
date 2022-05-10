////
////  Service.swift
////  PrecoEuroApi
////
////  Created by Luan.Lima on 20/04/22.
////
//
import Foundation

//MARK: Enum

enum NetworkingError: Error {
    case dataNotFound
    case serialization
}

class Service {
    
    var url = "https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL2"
    var session = URLSession.shared
    
    func euroValue(completion: @escaping ( String?, Error?) -> (Void )) {
        
        if let url = URL(string: url) {
            let task = session.dataTask(with: url) { (data, response, error)  in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(nil, NetworkingError.dataNotFound)
                    }
                    return
                }
                
                self.parseData(data: data, completion: completion)
            }
            
            task.resume()
        }
    }
    
    func parseData(data: Data, completion: @escaping ( String?, Error?) -> (Void )) {
       
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let brl = jsonObject["EURBRL"] as? [String: Any],
              let price = brl["bid"] as? String  else {
                  DispatchQueue.main.async {
                      completion(nil, NetworkingError.serialization)
                  }
                  return
              }
        DispatchQueue.main.async {
            completion(price, nil)
        }
    }
}
