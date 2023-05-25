//
//  PlantModel.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-03-28.
//

import Foundation
import UIKit

struct ImageURL : Codable{
    var original_url : String
}
struct PlantModel : Codable{
    var id : Int = -1
    var common_name : String = ""
    var scientific_name : [String] = []
    var cycle : String = ""
    var watering : String = ""
    var sunlight : [String] = []
    var default_image : ImageURL?

    static func decode (json : [String : Any]) -> PlantModel?{
        let decoder = JSONDecoder()
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try decoder.decode(PlantModel.self, from: data)
            return object
        } catch {}
        return nil
    }
}

struct ALlPlants : Codable{
    var data : [PlantModel]
    static func decode( json : [String : Any] ) -> ALlPlants? {
        let decoder = JSONDecoder()
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try decoder.decode(ALlPlants.self, from: data)
            return object
        } catch {}
        return nil
    }
    
}


