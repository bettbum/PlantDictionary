//
//  UIPlantDetailUtility.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-06.
//

import UIKit
import FirebaseAuth
protocol UIPlantDetailUtilityDelegate{
    func plantSaveHandler(_ sender : Any)
}
class UIPlantDetailUtility: UIView {
    
    var delegate : UIPlantDetailUtilityDelegate?
    
    public var isSaved : Bool = false{
        didSet{
            if(Auth.auth().currentUser != nil){
                btnSave.image = isSaved ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
            }
        }
    }
    var btnSave : UIImageView = {
        let btn = UIImageView()
        btn.image = UIImage(systemName: "bookmark")
        btn.tintColor = UIColor(named: "button_color")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(btnSave)
        applyContraints()
        addEventsForButtons()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func applyContraints(){
        NSLayoutConstraint.activate([
            btnSave.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnSave.centerXAnchor.constraint(equalTo: centerXAnchor),
            btnSave.widthAnchor.constraint(equalToConstant: 35),
            btnSave.heightAnchor.constraint(equalToConstant: 35)
        ])
        
    }
    func addEventsForButtons(){
        btnSave.enableTapGestureRecognizer(target: self, action: #selector(btnSaveTapped))
    }
    @objc func btnSaveTapped(){
        if(btnSave.image == UIImage(systemName: "bookmark")){
            isSaved = true
        }else if (btnSave.image == UIImage(systemName: "bookmark.fill")){
            isSaved = false
        }
        if(delegate != nil){
            delegate?.plantSaveHandler(self)
        }
    }

}
