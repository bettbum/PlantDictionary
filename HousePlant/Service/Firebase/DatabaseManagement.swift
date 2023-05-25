//
//  DatabaseManagement.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-04.
//

import Foundation
import UIKit
import Firebase

final class DatabaseManagement{
    public static var dbRef : DatabaseReference = Database.database().reference().child("data")
    static func addPlantSave (userUid : String, savedPlant : PlantModel){
        let objPlant = [
            "id": savedPlant.id,
            "common_name" : savedPlant.common_name,
            "scientific_name": savedPlant.scientific_name,
            "cycle" : savedPlant.cycle,
            "sunlight" : savedPlant.sunlight,
            "watering" : savedPlant.watering,
            "original_url" : savedPlant.default_image?.original_url
        ] as [String : Any]
        dbRef.child(userUid).child("listOfSavedPlants").child("\(savedPlant.id)").setValue(objPlant)
    }
    static func deletePlant (userUid : String, plantId : Int){
        dbRef.child(userUid).child("listOfSavedPlants").child("\(plantId)").setValue(nil)
    }
    static func getSavedPlant (userUid : String, plantId : Int) -> Bool{
        var isExisted = false
        dbRef.child(userUid).child("listOfSavedPlants").child("\(plantId)").getData(completion:  { error, snapshot in
            guard error == nil else {
              print(error!.localizedDescription)
              return;
            }
            isExisted = true
        })
        return isExisted
    }

}
