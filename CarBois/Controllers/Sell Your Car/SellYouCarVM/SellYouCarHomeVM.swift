//
//  SellYouCarHomeVM.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 23/02/2023.
//

import Foundation

class SellYouCarHomeVM {
    
    func getWanttoBuyListing(requestModel:wantToBuyListingRequest,onCompletion: @escaping (Result<WantToBuyListingModel,Error>) -> Void){
        WebAPI<wantToBuyListingRequest,WantToBuyListingModel>.postApiRequest(apiURL: ApiConstant.wantToBuyListing, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
    func submitForSalelisting(requestModel:sellcarSubmitRequest,onCompletion: @escaping (Result<SubmitsaleListingModel,Error>) -> Void){
        WebAPI<sellcarSubmitRequest,SubmitsaleListingModel>.postApiRequest(apiURL: ApiConstant.submitForSalelisting, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
    func contactBuyer(requestModel:sellcarSubmitRequest,onCompletion: @escaping (Result<ContactbuyerModel,Error>) -> Void){
        WebAPI<sellcarSubmitRequest,ContactbuyerModel>.postApiRequest(apiURL: ApiConstant.contactBuyer, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
    func getUploadLink(requestModel:getUploadLinkRequest,onCompletion: @escaping (Result<FileuploadlinkModel,Error>) -> Void){
        WebAPI<getUploadLinkRequest,FileuploadlinkModel>.postApiRequest(apiURL: ApiConstant.getfileUploadLink, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
    func getYears(requestModel:getyearReq,onCompletion: @escaping (Result<YearModel,Error>) -> Void){
        WebAPI<getyearReq,YearModel>.postApiRequest(apiURL: ApiConstant.getYearsFromSubGen, requestModel: requestModel) { (result) in
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



struct wantToBuyListingRequest:Codable{
    
    var carModelId : Int?
    var carMakeId : Int?
    var sub_gens_and_trim_defs : [sub_gens_and_trim_defs]?
    var pageLimit : Int?
    var pageOffset : Int?
    
    
}

struct getUploadLinkRequest:Codable{
    var UUID:String
}

struct getyearReq:Codable{
    var id:Int
}


//year model

struct YearModel:Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: YearModelDataClass?
}

// MARK: - DataClass
struct YearModelDataClass:Codable {
    let minYear, maxYear: Int?
}

