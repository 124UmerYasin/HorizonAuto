//
//  DashboardFilterViewModel.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import Foundation


class FilterVcViewModel {
    
    func getCarMake(onCompletion: @escaping (Result<CarMakeModel,Error>) -> Void){
        
        let requestModel = EmptyRequestModel()
        
        let url = ApiConstant.getCarMakes
        guard let urlString = URLComponents(string: url) else {
            return
        }
        
        WebAPI<EmptyRequestModel,CarMakeModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
                
            }
        }
    }
    
    func getCarModels(id:Int,onCompletion: @escaping (Result<CarMakeModel,Error>) -> Void){
        
        let requestModel = EmptyRequestModel()
        
        let url = ApiConstant.getCarModels
        guard var urlString = URLComponents(string: url) else {
            return
        }
        
        let queryItems = [URLQueryItem(name: "makeId", value: "\(id)")]
        urlString.queryItems = queryItems
        
        
        WebAPI<EmptyRequestModel,CarMakeModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
                
            }
        }
    }
    
    
    
    func getCarGenerations(id:Int,onCompletion: @escaping (Result<CarMakeModel,Error>) -> Void){
        
        let requestModel = EmptyRequestModel()
        
        let url = ApiConstant.getGenerations
        guard var urlString = URLComponents(string: url) else {
            return
        }
        
        let queryItems = [URLQueryItem(name: "carModelId", value: "\(id)")]
        urlString.queryItems = queryItems
        
        
        WebAPI<EmptyRequestModel,CarMakeModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
                
            }
        }
    }
    
    
    func getTrimRanges(id:Int,onCompletion: @escaping (Result<CarSubGenAndTrim,Error>) -> Void){
        
        let requestModel = DashboardFilterViewModelRequstMode(carGenerationId: id)
        
        let url = ApiConstant.getCarTrimsAndSubGenerations
        guard var urlString = URLComponents(string: url) else {
            return
        }
        
        let queryItems = [URLQueryItem(name: "carGenerationId", value: "\(id)")]
        urlString.queryItems = queryItems
        
        
        WebAPI<DashboardFilterViewModelRequstMode,CarSubGenAndTrim>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
                
            }
        }
    }
    
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
    
    func getHistoricGraphData(requestModel:multiHistoricGraphRequestModel,onCompletion: @escaping (Result<MultiHistoricGraphDataModel,Error>) -> Void){
        WebAPI<multiHistoricGraphRequestModel,MultiHistoricGraphDataModel>.postApiRequest(apiURL: ApiConstant.multiHistoricGraphData, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))
                
            }
        }
    }
    
    func getHistoriccarList(requestModel:multiHistoriccarRequestModel,onCompletion: @escaping (Result<MultiHistoricCarListing,Error>) -> Void){
        WebAPI<multiHistoriccarRequestModel,MultiHistoricCarListing>.postApiRequest(apiURL: ApiConstant.historiclistingcars, requestModel: requestModel) { (result) in
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
    
    //graph data in case of live
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
    //car listing in case of live
    func getLiveListing(requestModel:gethomecardetailListinghRequest,onCompletion: @escaping (Result<WantToSaleListingModel,Error>) -> Void){
        WebAPI<gethomecardetailListinghRequest,WantToSaleListingModel>.postApiRequest(apiURL: ApiConstant.getallForSaleListingsformakemodel, requestModel: requestModel) { (result) in
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


struct DashboardFilterViewModelRequstMode : Codable{
    var carGenerationId:Int
}

struct EmptyRequestModel : Codable{
}




