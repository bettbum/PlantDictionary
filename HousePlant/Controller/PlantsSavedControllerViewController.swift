//
//  PlantsSavedControllerViewController.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-05.
//

import UIKit
import FirebaseAuth
import Firebase
class PlantsSavedControllerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tableView = UITableView()
    var listOfSavedPlants = [PlantModel]()
    
    var lblTitle : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        lbl.text = "Saved list"
        lbl.textColor = UIColor(named: "button_color")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubViews(tableView, lblTitle)
        tableView.register(PlantTableViewCell.self, forCellReuseIdentifier: PlantTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        applyContraints()
        getListOfSavedPlants(userUid: Auth.auth().currentUser!.uid)
    }
    
    func applyContraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //lblTitle
            lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            //tableView
            tableView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        tableView.backgroundColor = UIColor(named: "background_color")
        tableView.separatorColor = UIColor.clear
        view.backgroundColor = UIColor(named: "background_color")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listOfSavedPlants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlantTableViewCell.identifier, for: indexPath) as! PlantTableViewCell
        cell.setContent(plant: listOfSavedPlants[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actDelete = UIContextualAction(style: .normal , title: ""){action, view, complete in
            let selectedPlant = self.listOfSavedPlants[indexPath.row]
            DatabaseManagement.deletePlant(userUid: Auth.auth().currentUser!.uid, plantId: selectedPlant.id)
            self.listOfSavedPlants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            complete(true)
        }
        actDelete.image = UIImage(systemName: "trash")
        actDelete.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [actDelete])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    func getListOfSavedPlants (userUid : String){
        DatabaseManagement.dbRef.child(userUid).child("listOfSavedPlants").observe(.value, with:{
            snapshot in
            self.listOfSavedPlants = []
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                if let plant = child.value as? Dictionary<String, Any>{
                    let id = plant["id"] as! Int
                    let common_name = plant["common_name"] as! String
                    let scientific_name = plant["scientific_name"] as! [String]
                    let sunlight = plant["sunlight"] as! [String]
                    let watering = plant["watering"] as! String
                    let cycle = plant["cycle"] as! String
                    let original_url = ImageURL(original_url: plant["original_url"] as! String)
                    let plantSave = PlantModel(id: id, common_name: common_name, scientific_name: scientific_name, cycle: cycle, watering: watering, sunlight: sunlight, default_image: original_url)
                    self.listOfSavedPlants.append(plantSave)
                    self.tableView.reloadData()
                }
            }
        })
    }

    

}
