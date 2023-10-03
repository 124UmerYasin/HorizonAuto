//
//  findYoucarHomeVM.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 23/02/2023.
//

import Foundation

import Foundation

class findYoucarHomeVM {
    
    func getWanttoSaleListing(requestModel:wantToBuyListingRequest,onCompletion: @escaping (Result<WantToSaleListingModel,Error>) -> Void){
        WebAPI<wantToBuyListingRequest,WantToSaleListingModel>.postApiRequest(apiURL: ApiConstant.wantToSaleListing, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
    
    func submitForBuyListing(requestModel:findcarSubmitRequest,onCompletion: @escaping (Result<SubmitBuyListingModel,Error>) -> Void){
        WebAPI<findcarSubmitRequest,SubmitBuyListingModel>.postApiRequest(apiURL: ApiConstant.submitForBuylisting, requestModel: requestModel) { (result) in
            switch result {
            case .success(let result):
                onCompletion(.success(result))
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                onCompletion(.failure(err))

            }
        }
    }
    
    func Contactseller(requestModel:findcarSubmitRequest,onCompletion: @escaping (Result<ContactSellerModel,Error>) -> Void){
        WebAPI<findcarSubmitRequest,ContactSellerModel>.postApiRequest(apiURL: ApiConstant.contactSeller, requestModel: requestModel) { (result) in
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
