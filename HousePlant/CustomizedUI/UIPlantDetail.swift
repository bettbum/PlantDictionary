//
//  UIPlantDetail.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-03-30.
//

import UIKit

class UIPlantDetail: UIView {
    
    private var imgPlant : UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 10
        img.layer.borderWidth = 3
        img.layer.borderColor = UIColor.white.cgColor
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private var lblCommonName : UILabel = {
        let lbl = UILabel()
        lbl.newHeaderLabel(text: "Common name")
        return lbl
    }()
    private var lblCommonNameValue : UILabel = {
        let lbl = UILabel ()
        lbl.newContentLabel()
        return lbl
    }()
    private var lblScientificName : UILabel = {
        let lbl = UILabel()
        lbl.newHeaderLabel(text: "Scientific name")
        return lbl
    }()
    private var lblScientificNameValue : UILabel = {
        let lbl = UILabel ()
        lbl.newContentLabel()
        return lbl
    }()
    private var lblCycle : UILabel = {
        let lbl = UILabel()
        lbl.newHeaderLabel(text: "Cycle")
        return lbl
    }()
    private var lblCycleValue : UILabel = {
        let lbl = UILabel ()
        lbl.newContentLabel()
        return lbl
    }()
    private var lblWatering: UILabel = {
        let lbl = UILabel()
        lbl.newHeaderLabel(text: "Watering")
        return lbl
    }()
    private var lblWateringValue : UILabel = {
        let lbl = UILabel ()
        lbl.newContentLabel()
        return lbl
    }()
    private var lblSunlight: UILabel = {
        let lbl = UILabel()
        lbl.newHeaderLabel(text: "Sunlight")
        return lbl
    }()
    private var lblSunlightValue : UILabel = {
        let lbl = UILabel ()
        lbl.newContentLabel()
        return lbl
    }()
    public func setContent (plant : PlantModel){
        imgPlant.fetchUImageFromURL(url: URL(string: plant.default_image!.original_url)!)
        lblCommonNameValue.text = plant.common_name
        lblScientificNameValue.text = plant.scientific_name[0]
        lblCycleValue.text = plant.cycle
        lblWateringValue.text = plant.watering
        lblSunlightValue.text = plant.sunlight.joined(separator: ", ")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(imgPlant, lblCommonName, lblCommonNameValue, lblScientificName, lblScientificNameValue, lblCycleValue,lblCycle, lblWatering, lblWateringValue, lblSunlight, lblSunlightValue)
        applyContraints()
        backgroundColor = UIColor(named: "background_color")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func applyContraints(){
        NSLayoutConstraint.activate([
            //imgPlant
            imgPlant.topAnchor.constraint(equalTo: topAnchor),
            imgPlant.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgPlant.widthAnchor.constraint(equalToConstant: 270),
            imgPlant.heightAnchor.constraint(equalToConstant: 300),
            
            //labels
            lblCommonName.topAnchor.constraint(equalTo: imgPlant.bottomAnchor, constant: 30),
            lblCommonName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lblCommonName.widthAnchor.constraint(equalToConstant: 150),
            lblCommonNameValue.centerYAnchor.constraint(equalTo: lblCommonName.centerYAnchor),
            lblCommonNameValue.leadingAnchor.constraint(equalTo: lblCommonName.trailingAnchor),
            lblCommonNameValue.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            lblScientificName.topAnchor.constraint(equalTo: lblCommonNameValue.bottomAnchor, constant: 10),
            lblScientificName.leadingAnchor.constraint(equalTo: lblCommonName.leadingAnchor),
            lblScientificNameValue.centerYAnchor.constraint(equalTo: lblScientificName.centerYAnchor),
            lblScientificNameValue.leadingAnchor.constraint(equalTo: lblCommonNameValue.leadingAnchor),
            lblScientificNameValue.trailingAnchor.constraint(equalTo: lblScientificNameValue.trailingAnchor),
            
            lblCycle.topAnchor.constraint(equalTo: lblScientificNameValue.bottomAnchor, constant: 10),
            lblCycle.leadingAnchor.constraint(equalTo: lblScientificName.leadingAnchor),
            lblCycleValue.centerYAnchor.constraint(equalTo: lblCycle.centerYAnchor),
            lblCycleValue.leadingAnchor.constraint(equalTo: lblCommonNameValue.leadingAnchor),
            lblCycle.trailingAnchor.constraint(equalTo: lblCycleValue.trailingAnchor),
            
            lblWatering.topAnchor.constraint(equalTo: lblCycleValue.bottomAnchor, constant: 10),
            lblWatering.leadingAnchor.constraint(equalTo: lblCycle.leadingAnchor),
            lblWateringValue.centerYAnchor.constraint(equalTo: lblWatering.centerYAnchor),
            lblWateringValue.leadingAnchor.constraint(equalTo: lblCommonNameValue.leadingAnchor),
            lblWateringValue.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            lblSunlight.topAnchor.constraint(equalTo: lblWateringValue.bottomAnchor, constant: 10),
            lblSunlight.leadingAnchor.constraint(equalTo: lblWatering.leadingAnchor),
            lblSunlightValue.centerYAnchor.constraint(equalTo: lblSunlight.centerYAnchor),
            lblSunlightValue.leadingAnchor.constraint(equalTo: lblCommonNameValue.leadingAnchor),
            lblSunlightValue.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}
