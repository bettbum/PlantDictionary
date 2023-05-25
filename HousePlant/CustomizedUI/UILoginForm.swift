//
//  UILoginForm.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-03.
//

import UIKit
protocol UILoginFormDelegate {
    func btnSignUpTapped ( _ sender : Any)
    func btnSignInTapped ( _ sender : Any)
}
class UILoginForm: UIView{
    
    public var email : String = ""
    public var password : String = ""
    
    var delegate : UILoginFormDelegate?
    private var txtEmail : UITextField = {
        let txt = UITextField()
        txt.newTextField(placeholder: "Email")
        return txt
    }()
    private var txtPassword : UITextField = {
        let txt = UITextField()
        txt.isSecureTextEntry = true
        txt.newTextField(placeholder: "Password")
        return txt
    }()
    

    private var btnLogin : UIButton = {
        let btn = UIButton()
        btn.newButton(title: "Login", backgroundColor: UIColor(named: "button_color")!.withAlphaComponent(0.5))
        return btn
    }()
    private var btnSignUp : UIButton = {
        let btn = UIButton()
        btn.newButton(title: "Sign Up", backgroundColor: UIColor(named: "background_color")!)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews( txtEmail, txtPassword, btnLogin, btnSignUp)
        applyContraints()
        addEventsForButtons()
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func applyContraints(){
        NSLayoutConstraint.activate([
            
            //txtUsername
            txtEmail.centerXAnchor.constraint(equalTo: centerXAnchor),
            txtEmail.widthAnchor.constraint(equalToConstant: 300),
            txtEmail.heightAnchor.constraint(equalToConstant: 50),
            
            //txtPassword
            txtPassword.leadingAnchor.constraint(equalTo: txtEmail.leadingAnchor),
            txtPassword.trailingAnchor.constraint(equalTo: txtEmail.trailingAnchor),
            txtPassword.topAnchor.constraint(equalTo: txtEmail.bottomAnchor,constant: 20),
            txtPassword.heightAnchor.constraint(equalToConstant: 50),
            
            //btnLogin
            btnLogin.centerXAnchor.constraint(equalTo: txtEmail.centerXAnchor),
            btnLogin.topAnchor.constraint(equalTo: txtPassword.bottomAnchor,constant: 40),
            btnLogin.widthAnchor.constraint(equalToConstant: 100),
            
            //btnSignUp
            btnSignUp.centerXAnchor.constraint(equalTo: txtEmail.centerXAnchor),
            btnSignUp.topAnchor.constraint(equalTo: btnLogin.bottomAnchor,constant: 15),
            btnSignUp.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    func addEventsForButtons(){
        btnLogin.addTarget(self, action: #selector(btnSignInTapped), for: .touchUpInside)
        btnSignUp.addTarget(self, action: #selector(btnSignUpTapped), for: .touchUpInside)
    }
    @objc func btnSignUpTapped( _ sender : UIButton){
        if (delegate != nil){
            delegate?.btnSignUpTapped(self)
        }
    }
    @objc func btnSignInTapped ( _ sender : UIButton){
        email = txtEmail.text!
        password = txtPassword.text!
        if(delegate != nil){
            delegate?.btnSignInTapped(self)
        }
    }
}
