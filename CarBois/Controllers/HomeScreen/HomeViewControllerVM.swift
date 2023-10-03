//
//  HomeViewControllerVM.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 07/10/2022.
//

import Foundation


class HomeViewControllerVM{
    func getGraphData(requestModel:averageGraphRequestModel,onCompletion: @escaping (Result<AverageGraphDataModel,Error>) -> Void){
        WebAPI<averageGraphRequestModel,AverageGraphDataModel>.postApiRequest(apiURL: ApiConstant.averagesGraphData, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
    func getModelPricingData(requestModel:ModelPricingDataRequest,onCompletion: @escaping (Result<ModelPricingDataModel,Error>) -> Void){
        
        let requestModel = requestModel
        let url = ApiConstant.modelPricing
        guard var urlString = URLComponents(string: url) else {
            return
        }
        let queryItems = [URLQueryItem(name: "carType", value: "\(requestModel.carType)"),URLQueryItem(name: "carMakeId", value: "\(requestModel.carMakeId)"),URLQueryItem(name: "carModelId", value: "\(requestModel.carModelId)")]
        urlString.queryItems = queryItems
        
        WebAPI<ModelPricingDataRequest,ModelPricingDataModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
    func getAverageGraphCarList(requestModel:AverageGraphCarListRequest,onCompletion: @escaping (Result<AverageGraphCarListModel,Error>) -> Void){
        WebAPI<AverageGraphCarListRequest,AverageGraphCarListModel>.postApiRequest(apiURL: ApiConstant.averagePriceCarList, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    func getHotpicks(onCompletion: @escaping (Result<HotPicksDataModel,Error>) -> Void){
        let url = ApiConstant.hotPicks
        guard let urlString = URLComponents(string: url) else {
            return
        }
        let requestModel = getHotPicksRequest()
        WebAPI<getHotPicksRequest,HotPicksDataModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
            }
        }
    }
    
    func getMarqueeData(onCompletion: @escaping (Result<MarqueeModel,Error>) -> Void){
        let url = ApiConstant.getMarqueeData
        guard let urlString = URLComponents(string: url) else {
            return
        }
        let requestModel = getMarqueeRequest()
        WebAPI<getMarqueeRequest,MarqueeModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
            }
        }
    }
    
    func getFeaturedListing(onCompletion: @escaping (Result<FeaturedListingModel,Error>) -> Void){
        let url = ApiConstant.getFeaturedListings
        guard let urlString = URLComponents(string: url) else {
            return
        }
        let requestModel = getFeaturedListingRequest()
        WebAPI<getFeaturedListingRequest,FeaturedListingModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
            }
        }
    }
    
    func getSaleListingData(onCompletion: @escaping (Result<GetuserSaleListingoMdel,Error>) -> Void){
        let url = ApiConstant.getusersForSalelistings
        guard let urlString = URLComponents(string: url) else {
            return
        }
        let requestModel = getuserSaleListingRequest()
        WebAPI<getuserSaleListingRequest,GetuserSaleListingoMdel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
            }
        }
    }
    
    func getWTBListingData(onCompletion: @escaping (Result<GetuserWTBListingoModel,Error>) -> Void){
        let url = ApiConstant.getusersWTBlistings
        guard let urlString = URLComponents(string: url) else {
            return
        }
        let requestModel = getuserWTBListingRequest()
        WebAPI<getuserWTBListingRequest,GetuserWTBListingoModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
            }
        }
    }
    
    //home car detail
    func getHomeCarDetail(requestModel:getHomeCarDetailRequest,onCompletion: @escaping (Result<HomecardetailModel,Error>) -> Void){
        
        
        let requestModel = requestModel
        let url = ApiConstant.horizonautolistingcardetails
        guard var urlString = URLComponents(string: url) else {
            return
        }
        let queryItems = [URLQueryItem(name: "uuid", value: "\(requestModel.uuid)")]
        urlString.queryItems = queryItems

        WebAPI<getHomeCarDetailRequest,HomecardetailModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
            }
        }
    }
    //home car detail listing
    func getHomeCarDetaillisting(requestModel:gethomecardetailListingRequest,onCompletion: @escaping (Result<HomeCarDetailListing,Error>) -> Void){
        
        let requestModel = requestModel
        let url = ApiConstant.getsimilarhorizonautolistings
        guard var urlString = URLComponents(string: url) else {
            return
        }
        let queryItems = [URLQueryItem(name: "uuid", value: "\(requestModel.uuid)")]
        urlString.queryItems = queryItems
        
        WebAPI<gethomecardetailListingRequest,HomeCarDetailListing>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
            }
        }
    }
    //home car detail graph
    func getHomeCarDetailgraph(requestModel:gethomecardetailGraphRequest,onCompletion: @escaping (Result<HomeCarDetailGraph,Error>) -> Void){
        WebAPI<gethomecardetailGraphRequest,HomeCarDetailGraph>.postApiRequest(apiURL: ApiConstant.gethorizonautoForSalegraphdata, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
 
    //home car detail listing with token
    func getHomeCarDetaillistingWithToken(requestModel:gethomecardetailListingRequest,onCompletion: @escaping (Result<HomeCarDetailListing,Error>) -> Void){
        
        let requestModel = requestModel
        let url = ApiConstant.getlistingresponses
        guard var urlString = URLComponents(string: url) else {
            return
        }
        let queryItems = [URLQueryItem(name: "uuid", value: "\(requestModel.uuid)")]
        urlString.queryItems = queryItems
        
        WebAPI<gethomecardetailListingRequest,HomeCarDetailListing>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
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
