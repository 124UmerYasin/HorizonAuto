//
//  enumsContants.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 30/09/2022.
//

import Foundation

enum tenure : String {
    case oneMonth = "one_month"
    case threeMonth = "three_months"
    case sixMonth = "six_months"
    case oneYear = "one_year"
    case twoYest = "two_years"
    case threeYear = "three_years"
    case all = "all"
    
}


enum TitleInfo:String {
    case Clean = "Clean Title"
    case Salvage = "Salvage Title"
    case flood = "Flood Title"
    case rebuilt = "Rebuilt Title"
    case unknown = "No title info available"
}

enum TransmissionType :String{
  case manual = "Manual"
  case auto = "Automatic"
}


enum CarfaxAccidentInfo : String{
  case accident = "Accident"
  case noAccident = "No Accident"
  case unknown = "Unkown"
  case noCarfax = "No Carfax Available"
}


enum DriveTypeENUM : String{
 case RWD = "Rear Wheel Drive"
 case AWD = "All Wheel Drive"
 case FWD = "Front Wheel Drive"
 case Ani = "Uncertain"
}


enum EngineLayout : String{
    case rear = "Rear Engined"
    case mid = "Mid Engined"
    case front = "Front Engined"
}
