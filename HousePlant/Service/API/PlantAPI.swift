//
//  PlantAPI.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-03-28.
//

import Foundation
import UIKit

class PlantAPI{
    static let key = "sk-BgwA6421ef94e8897364"
    static let baseURL = "https://perenual.com/api/species-list?key=" + key
    static func getAllPlants(pageNumber : Int, successHandler: @escaping (_ httpStatusCode : Int, _                       response : [String: Any]) -> Void,
                           failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage: String) -> Void) {
        
        let endPoint = "&page=\(pageNumber)"
        
        let payload : [String:String] = [:]
        
        API.call(baseURL: baseURL, endPoint: endPoint, method: "GET", payload: payload, successHandler: successHandler, failHandler: failHandler)
    }
    static func getPlantsWithKeywords(keyword : String, successHandler: @escaping (_ httpStatusCode : Int, _                       response : [String: Any]) -> Void,
                           failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage: String) -> Void) {
        
        let endPoint = "&q=\(keyword)"
        
        let payload : [String:String] = [:]
        
        API.call(baseURL: baseURL, endPoint: endPoint, method: "GET", payload: payload, successHandler: successHandler, failHandler: failHandler)
    }
}
