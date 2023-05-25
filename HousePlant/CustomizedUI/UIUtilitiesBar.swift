//
//  UIUtilitiesBar.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-03.
//

import UIKit
import FirebaseAuth
protocol UIUtilitiesBarDelegate {
    func btnUserTapped (_ sender : Any)
    func btnSaveTapped (_ sender : Any)
    func btnLogoutTapped (_ sender : Any)
}
class UIUtilitiesBar: UIView {
    var delegate : UIUtilitiesBarDelegate?
    public var isUserLogged : Bool = Auth.auth().currentUser != nil{
        didSet{
            btnUser.isHidden = isUserLogged
            lblLoggedUserEmail.text = isUserLogged ? Auth.auth().currentUser?.email : ""
            btnLogout.isHidden = !isUserLogged
        }
    }
    var btnUser : UIImageView = {
        let btn = UIImageView()
        btn.image = UIImage(systemName: "person.crop.circle")
        btn.tintColor = UIColor(named: "button_color")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    var btnSave : UIImageView = {
        let btn = UIImageView()
        btn.image = UIImage(systemName: "bookmark.circle")
        btn.tintColor = UIColor(named: "button_color")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    var lblLoggedUserEmail : UILabel = {
        let lbl = UILabel()
        lbl.tintColor = UIColor(named: "button_color")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    var btnLogout : UIButton = {
        let btn = UIButton()
        btn.setTitle("Log out", for: .normal)
        btn.backgroundColor = UIColor(named: "background_color")
        btn.tintColor = UIColor(named: "button_color")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(btnUser, btnSave, lblLoggedUserEmail, btnLogout )
        applyConstraints()
        addEventsForButton()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func addEventsForButton(){
        btnUser.enableTapGestureRecognizer(target: self, action: #selector(btnUserTapped))
        btnSave.enableTapGestureRecognizer(target: self, action: #selector(btnSaveTapped))
        btnLogout.addTarget(self, action: #selector(btnLogoutTapped), for: .touchUpInside)
    }
    
    func applyConstraints(){
        NSLayoutConstraint.activate([
            //btnSave
            btnSave.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            btnSave.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnSave.heightAnchor.constraint(equalToConstant: 30),
            btnSave.widthAnchor.constraint(equalToConstant: 30),
            
            //btnUser
            btnUser.trailingAnchor.constraint(equalTo: btnSave.leadingAnchor, constant: -15),
            btnUser.topAnchor.constraint(equalTo: btnSave.topAnchor),
            btnUser.heightAnchor.constraint(equalToConstant: 30),
            btnUser.widthAnchor.constraint(equalToConstant: 30),
            
            //lblLoggedUsername
            lblLoggedUserEmail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lblLoggedUserEmail.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            //btnLogout
            btnLogout.leadingAnchor.constraint(equalTo: lblLoggedUserEmail.trailingAnchor, constant: 10),
            btnLogout.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    @objc func btnUserTapped(_ sender : Any){
        if(delegate != nil){
            delegate?.btnUserTapped(self)
        }
    }
    @objc func btnSaveTapped(_ sender : Any){
        if(delegate != nil){
            delegate?.btnSaveTapped(self)
        }
    }
    @objc func btnLogoutTapped (_ sender : Any){
        if(delegate != nil){
            delegate?.btnLogoutTapped(self)
        }
    }

}
