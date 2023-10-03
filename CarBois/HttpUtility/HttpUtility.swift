//
//  HttpUtility.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import Foundation
import Alamofire



class HttpUtility {
    
    static let shared = HttpUtility()

    //MARK: -  Request Header
    private func requestHeader() -> HTTPHeaders  {
        
        var header : HTTPHeaders = [:]
        header = ["Content-Type":"application/json"]
        return header
        
    }
    //MARK: -  Get Request api call

    func getRequest(fromURL urlStr:URLComponents,parameters:Dictionary<String,Any>,completionHandler:@escaping (_ error:Error?, _ jsonData:Data?, _ statusCode:Int?)->Void) -> Void {
        
        var header : HTTPHeaders = [:]
        header = ["Content-Type":"application/json"]
        
        if urlStr.url?.absoluteString == ApiConstant.getusersForSalelistings{
            header = ["Content-Type":"application/json","Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)"]
        }
        if urlStr.url?.absoluteString == ApiConstant.getusersWTBlistings{
            header = ["Content-Type":"application/json","Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)"]
        }
        if urlStr.url?.path == "/get-listing-responses"{
            header = ["Content-Type":"application/json","Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)"]
        }

        
        AF.request(urlStr, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData { response in
            
            let statusCode = response.response?.statusCode
            switch response.result {
                
            case .success(_):
                completionHandler(nil, response.data, statusCode)
            case .failure(_):
                completionHandler(response.error, nil, statusCode)
            }
            
        }
        
    }
    
    //MARK: -  Post Request api call

    func postRequest(fromURL urlStr:String, parameters:Dictionary<String,Any>,completionHandler:@escaping (_ error:Error?, _ jsonData:Data?, _ statusCode:Int?)->Void) {
        
        
        guard let urlString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) else {
            return
        }
        
        var header : HTTPHeaders = [:]
        header = ["Content-Type":"application/json"]

        if urlString.contains(ApiConstant.submitForSalelisting){
            header = ["Content-Type":"application/json","Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)"]
        }
        if urlString.contains(ApiConstant.submitForBuylisting){
            header = ["Content-Type":"application/json","Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)"]
        }
        if urlString.contains(ApiConstant.contactBuyer){
            header = ["Content-Type":"application/json","Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)"]
        }
        if urlString.contains(ApiConstant.contactSeller){
            header = ["Content-Type":"application/json","Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)"]
        }
        if urlString.contains(ApiConstant.getfileUploadLink){
            header = ["Content-Type":"application/json","Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)"]
        }
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        var request = URLRequest(url: url)
        request.headers = header;
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        AF.request(request).responseData { response in
            
            let statusCode = response.response?.statusCode
            switch response.result {
                
            case .success(_):
                completionHandler(nil, response.data, statusCode)
            case .failure(_):
                completionHandler(response.error, nil, statusCode)
            }
            
        }
        
        
    }
    
    
    
}

//MARK: -  Dictionary Extension.

extension Dictionary {

    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }

    func printJson() {
        print(json)
    }

}
