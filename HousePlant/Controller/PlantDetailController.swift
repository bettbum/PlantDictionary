//
//  PlantDetailController.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-03-30.
//

import UIKit
import FirebaseAuth
class PlantDetailController: UIViewController, UIPlantDetailUtilityDelegate{
    
    

    public var selectedPlant : PlantModel?
    
    var plantDetail = UIPlantDetail()
    var logo = Logo()
    var plantDetailUtility = UIPlantDetailUtility()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubViews(plantDetail, logo, plantDetailUtility)
        applyConstraints()
        if(selectedPlant != nil){
            plantDetail.setContent(plant: selectedPlant!)
            if(Auth.auth().currentUser != nil){
                //check if the plant detail is in the saved list
                DatabaseManagement.dbRef.child(Auth.auth().currentUser!.uid).child("listOfSavedPlants").getData(completion:  { [self] error, snapshot in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return;
                    }
                    if(snapshot!.hasChild("\(selectedPlant!.id)")){
                        self.plantDetailUtility.isSaved = true
                    }
                })
            }
        }
        plantDetailUtility.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    func applyConstraints(){
        logo.translatesAutoresizingMaskIntoConstraints = false
        plantDetail.translatesAutoresizingMaskIntoConstraints = false
        plantDetailUtility.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //logo
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            logo.heightAnchor.constraint(equalToConstant: 120),
            
            //plant detail
            plantDetail.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            plantDetail.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            plantDetail.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            //btnSave
            plantDetailUtility.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            plantDetailUtility.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            plantDetailUtility.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            plantDetailUtility.heightAnchor.constraint(equalToConstant: 70),

        ])
        
        //applying ui
        view.backgroundColor = UIColor(named: "background_color")
    }
    func plantSaveHandler(_ sender: Any) {
        if(Auth.auth().currentUser != nil){
            if(plantDetailUtility.isSaved == true){
                DatabaseManagement.addPlantSave(userUid: Auth.auth().currentUser!.uid, savedPlant: selectedPlant!)
            }else{
                DatabaseManagement.deletePlant(userUid: Auth.auth().currentUser!.uid, plantId: selectedPlant!.id)
            }
        }else{
            Toast.ok(view: self, title: "You need to login first", message: "")
        }

    }
    

}
