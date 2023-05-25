//
//  ViewController.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-03-27.
//

import UIKit
import FirebaseAuth
class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, PageNavigationDelegate, UIUtilitiesBarDelegate{
    
    var tableView = UITableView()
    
    var searchBar : UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    var searching = false
    var listOfSearchPlants = [PlantModel]()
    
    var listOfPlants = [PlantModel]()
    
    var logo = Logo()
    var pageNavigation = UIPageNavigation()
    var utilitiesBar = UIUtilitiesBar()
    
    var selectedPlant : PlantModel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPIGetAllPlants(pageNumber: 1)
        
        tableView.register(PlantTableViewCell.self, forCellReuseIdentifier: PlantTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        searchBar.delegate = self
        pageNavigation.delegate = self
        utilitiesBar.delegate = self
        
        view.addSubViews(tableView, searchBar, logo, pageNavigation, utilitiesBar)
        applyContraints()
        utilitiesBar.isUserLogged = Auth.auth().currentUser != nil
    }
    required init?(coder aDecoder: NSCoder) {
        self.selectedPlant = PlantModel()
        super.init(coder: aDecoder)
        
    }
    func applyContraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        pageNavigation.translatesAutoresizingMaskIntoConstraints = false
        utilitiesBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //utilitiesBar
            utilitiesBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            utilitiesBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            utilitiesBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            utilitiesBar.heightAnchor.constraint(equalToConstant: 40),
            
            //logo
            logo.topAnchor.constraint(equalTo: utilitiesBar.bottomAnchor),
            logo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            logo.heightAnchor.constraint(equalToConstant: 120),
            
            //search bar
            searchBar.topAnchor.constraint(equalTo: logo.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            //pageNavigation
            pageNavigation.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            pageNavigation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageNavigation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageNavigation.heightAnchor.constraint(equalToConstant: 60),
            
            //table View
            tableView.topAnchor.constraint(equalTo: pageNavigation.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        //implement UI
        tableView.backgroundColor = UIColor(named: "background_color")
        tableView.separatorColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        view.backgroundColor = UIColor(named: "background_color")
    }
    func callAPIGetAllPlants(pageNumber : Int){
        PlantAPI.getAllPlants(pageNumber: pageNumber){ httpStatusCode, response in
            DispatchQueue.main.async{ [self] in
                if httpStatusCode == 200{
                    listOfPlants = ALlPlants.decode(json: response)!.data
                    self.tableView.reloadData()
                }else{
                   print("error http status code")
                }
            }
        }failHandler: { httpStatusCode, errorMessage in
            DispatchQueue.main.async{
                print(errorMessage)
            }
        }
    }
    func callAPIgGetPlantsWithKeywords(keyword : String){
        PlantAPI.getPlantsWithKeywords(keyword: keyword){ httpStatusCode, response in
            DispatchQueue.main.async{ [self] in
                if httpStatusCode == 200{
                    listOfSearchPlants = ALlPlants.decode(json: response)!.data
                    searching = true
                    tableView.reloadData()
                }else{
                   print("error http status code")
                }
            }
        }failHandler: { httpStatusCode, errorMessage in
            DispatchQueue.main.async{
                print(errorMessage)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if searching{
            return listOfSearchPlants.count
        }
        return listOfPlants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlantTableViewCell.identifier, for: indexPath) as! PlantTableViewCell
        var plant : PlantModel
        if(searching){
            plant = listOfSearchPlants[indexPath.row]
        }else{
            plant = listOfPlants[indexPath.row]
        }
        cell.setContent(plant: plant)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(searching){
            selectedPlant = listOfSearchPlants[indexPath.row]
        }else{
            selectedPlant = listOfPlants[indexPath.row]
        }
        performSegue(withIdentifier: "toPlantDetailController", sender: nil)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        callAPIgGetPlantsWithKeywords(keyword: searchText)
        pageNavigation.page = 1
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    func btnPageTapped(_ sender: Any) {
        let pageNumber = pageNavigation.page
        callAPIGetAllPlants(pageNumber: pageNumber)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toPlantDetailController"){
            let plantDetailController = segue.destination as! PlantDetailController
            plantDetailController.selectedPlant = self.selectedPlant
        }
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "toPlantDetailController"){
            if selectedPlant != nil{
                return true
            }
            return false
        }
        if (identifier == "ToLoginPage" ){
            return true
        }
        if (identifier == "ToPlantsSavedController"){
            return true
        }
        
        return false
    }
    func btnUserTapped(_ sender: Any) {
        performSegue(withIdentifier: "ToLoginPage", sender: nil)
        
    }
    
    func btnSaveTapped(_ sender: Any) {
        if (Auth.auth().currentUser != nil){
            performSegue(withIdentifier: "ToPlantsSavedController", sender: nil)
        }else{
            Toast.ok(view: self, title: "You need to login first", message: ""){result in
                self.performSegue(withIdentifier: "ToLoginPage", sender: nil)
            }
        }
    }
    
    func btnLogoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            utilitiesBar.isUserLogged = false
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    

}

