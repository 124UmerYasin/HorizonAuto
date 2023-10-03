//
//  WebAPI.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import Foundation

class WebAPI <request: Codable,response: Decodable>{
    
    
    static func postApiRequest(apiURL:String , requestModel:request ,onCompletion: @escaping (Result<response,Error>) -> Void) {
        
        if CheckInternet.Connection() {
            
            print(apiURL)
            
            guard let parameters = requestModel.dictionary else { return }
            
            HttpUtility.shared.postRequest(fromURL: apiURL, parameters: parameters) { error, jsonData, statusCode in
                
                if let err = error {
                    let errr = CustomError(description: err.localizedDescription)
                    DispatchQueue.main.async {
                        onCompletion(.failure(errr))
                    }
                }else{
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: jsonData!, options: [])
//                        print(jsonResponse)
                        
                        if statusCode != 200 && statusCode != 401 {
                            let message = (jsonResponse as AnyObject).value(forKey: "message") as? String ?? ""
                            let error = CustomError(description: message)
                            DispatchQueue.main.async {
                                onCompletion(.failure(error))
                            }
                        }
//                        print(jsonResponse)
                        if statusCode == 200 || statusCode == 201 {
                            let successStr = (jsonResponse as AnyObject).value(forKey: "status") as? String ?? "Faliure"
                            if successStr == "success" {
                                //if statusCode == 200 {
                                let responseModel = try JSONDecoder().decode(response.self, from: jsonData!)
                                DispatchQueue.main.async {
                                    onCompletion(.success(responseModel))
                                }
                            } else {
                                let messageStr = (jsonResponse as AnyObject).value(forKey: "moreInfo") as? String ?? "Internet issue"
                                let error = CustomError(description: messageStr )
                                DispatchQueue.main.async {
                                    
                                    onCompletion(.failure(error))
                                }
                            }
                        }
                        
                    } catch let error {
                        debugPrint(error)
                        let err = CustomError(description: error.localizedDescription)
                        DispatchQueue.main.async {
                            onCompletion(.failure(err))
                        }
                    }
                    
                }
                
            }
        }else{
            let err = CustomError(description: "No Internet Available. Please Check Your Internet Connection.")
            DispatchQueue.main.async {
                onCompletion(.failure(err))
            }
        }
        
    }
    
    static func getApiRequest(apiURL:URLComponents , requestModel:request ,onCompletion: @escaping (Result<response,Error>) -> Void) {
        
        if CheckInternet.Connection() {
            
            
            print(apiURL)
            
            guard let parameters = requestModel.dictionary else { return }
            
            HttpUtility.shared.getRequest(fromURL: apiURL, parameters: parameters) { error, jsonData, statusCode in
                
                if let err = error {
                    let errr = CustomError(description: err.localizedDescription)
                    DispatchQueue.main.async {
                        onCompletion(.failure(errr))
                    }
                }else{
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: jsonData!, options: [])
                        print(jsonResponse)
                        
                        if statusCode != 200 && statusCode != 401 {
                            let message = (jsonResponse as AnyObject).value(forKey: "message") as? String ?? ""
                            let error = CustomError(description: message)
                            DispatchQueue.main.async {
                                onCompletion(.failure(error))
                            }
                        }
                        print(jsonResponse)
                        if statusCode == 200 || statusCode == 201 {
                            let successStr = (jsonResponse as AnyObject).value(forKey: "status") as? String ?? "Faliure"
                            if successStr == "success" {
                                //if statusCode == 200 {
                                let responseModel = try JSONDecoder().decode(response.self, from: jsonData!)
                                DispatchQueue.main.async {
                                    onCompletion(.success(responseModel))
                                }
                            } else {
                                let messageStr = (jsonResponse as AnyObject).value(forKey: "moreInfo") as? String ?? "Internet issue"
                                let error = CustomError(description: messageStr )
                                DispatchQueue.main.async {
                                    onCompletion(.failure(error))
                                }
                            }
                        }
                        
                    } catch let error {
                        debugPrint(error)
                        let err = CustomError(description: error.localizedDescription)
                        DispatchQueue.main.async {
                            onCompletion(.failure(err))
                        }
                    }
                    
                }
                
            }
        }else{
            let err = CustomError(description: "No Internet Available. Please Check Your Internet Connection.")
            DispatchQueue.main.async {
                onCompletion(.failure(err))
            }
        }
        
    }
    
    
}
