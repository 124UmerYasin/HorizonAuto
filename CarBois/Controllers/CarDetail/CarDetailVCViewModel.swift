//
//  CarDetailVCViewModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 09/11/2022.
//

import Foundation


class CarDetailVCViewModel{
    
    func getFilterListing(requestModel:CarDetailFilterListingRequest,onCompletion: @escaping (Result<CarDetailsGraphFiltersList,Error>) -> Void){
        WebAPI<CarDetailFilterListingRequest,CarDetailsGraphFiltersList>.postApiRequest(apiURL: ApiConstant.carDetailFilterListing, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
                
            }
        }
    }
    
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
    
}




struct CarDetailFilterListingRequest:Codable{
    var id:Int
    var filters : [filtersRequest]?
    var view_live_data:Bool?
    var sortBy:String?

}
