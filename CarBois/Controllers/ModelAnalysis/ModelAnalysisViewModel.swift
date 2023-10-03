//
//  ModelAnalysisViewModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 10/10/2022.
//

import Foundation

class ModelAnalysisViewModel{
    func getCarDetail(requestModel:CarDetailRequestModel,onCompletion: @escaping (Result<CarDetailModel,Error>) -> Void){
        let requestModel = requestModel
        let url = ApiConstant.carDetail
        guard var urlString = URLComponents(string: url) else {
            return
        }
        let queryItems = [URLQueryItem(name: "id", value: "\(requestModel.id)")]
        urlString.queryItems = queryItems
        
        WebAPI<CarDetailRequestModel,CarDetailModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
        
    }
    
    func getCarDetailGraph(requestModel:CarDetailRequestModel,onCompletion: @escaping (Result<CarDetailGraphModel,Error>) -> Void){
        
        WebAPI<CarDetailRequestModel,CarDetailGraphModel>.postApiRequest(apiURL: ApiConstant.carDetailGraph, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
    func getAverageGraphFilterListing(requestModel:AverageGraphFilterListingRequestModel,onCompletion: @escaping (Result<AverageGraphFiltersList,Error>) -> Void){
        WebAPI<AverageGraphFilterListingRequestModel,AverageGraphFiltersList>.postApiRequest(apiURL: ApiConstant.averageGraphFilterList, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
    func getHistoricGraphFilterListing(request:multiHistoricGraphRequestModel,onCompletion: @escaping (Result<MultiHistoricGraphFiltersList,Error>) -> Void){
        WebAPI<multiHistoricGraphRequestModel,MultiHistoricGraphFiltersList>.postApiRequest(apiURL: ApiConstant.multiHistoricGraphFilerListing, requestModel: request) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
                
            }
        }
    }
    
    func getCarDetailSimilarListing(requestModel:CarDetailRequestModel,onCompletion: @escaping (Result<CarDetailsSimilarListings,Error>) -> Void){
        
        WebAPI<CarDetailRequestModel,CarDetailsSimilarListings>.postApiRequest(apiURL: ApiConstant.carDetailSimilarListing, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
}



struct CarDetailRequestModel : Codable{
    var id:Int
    var filters : [filtersRequest]?
    var view_live_data:Bool?
    var limit: Int?
    var offset: Int?
    var sortBy:String?

}


struct AverageGraphFilterListingRequestModel : Codable {
    var carType: String?
    var carMakeId: Int?
    var carModelId: Int?
    var tenure: String?
    var filters : [filtersRequest]?
    var view_live_data:Bool?
    var sortBy:String?
}

struct filtersRequest : Codable,Hashable {
    
    init(key: String, min: Int? = nil, max: Int? = nil,list : [String]? = nil) {
        self.key = key
        self.min = min
        self.max = max
        self.list = list
    }
    
    let key : String
    let min, max: Int?
    let list: [String]?
}

