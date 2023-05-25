//
//  PlantTableViewCell.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-03-28.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    
    public static let identifier = "PlantTableViewCell"
    
    private var imgPlant : UIImageView = {
        let img = UIImageView()
        img.layer.borderWidth = 2
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.cornerRadius = 38
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private var lblCommonName : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private var lblScienceName : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15, weight: .light)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    public func setContent (plant : PlantModel){
        imgPlant.fetchUImageFromURL(url: URL(string: plant.default_image!.original_url)!)
        lblCommonName.text = plant.common_name
        lblScienceName.text = plant.scientific_name[0]
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
        if (selected){
            contentView.backgroundColor = UIColor(named: "button_color")
        }else{
            contentView.backgroundColor = UIColor(named: "background_color")
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubViews(imgPlant, lblCommonName, lblScienceName)
        applyConstraints()
        backgroundColor = UIColor(named: "background_color")
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    func applyConstraints(){
        NSLayoutConstraint.activate([
            //image
            imgPlant.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imgPlant.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            imgPlant.heightAnchor.constraint(equalToConstant: 76),
            imgPlant.widthAnchor.constraint(equalToConstant: 76),
            
            //commonName
            lblCommonName.topAnchor.constraint(equalTo: imgPlant.topAnchor, constant: 10),
            lblCommonName.leadingAnchor.constraint(equalTo: imgPlant.trailingAnchor, constant: 20),
            lblCommonName.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //scientific name
            lblScienceName.topAnchor.constraint(equalTo: lblCommonName.bottomAnchor, constant: 10),
            lblScienceName.leadingAnchor.constraint(equalTo: lblCommonName.leadingAnchor),
            lblScienceName.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}
