//
//  UISignUpForm.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-04.
//

import UIKit
protocol UISignUpFormDelegate{
    func formSubmitHandler (_ sender : Any)
}
class UISignUpForm: UIView {
    var delegate : UISignUpFormDelegate?
    
    public var email : String = ""
    public var password : String = ""
    public var isValidPassword : Bool = false
    public var isValidEmailPassword : Bool = false{
        didSet{
            if (delegate != nil){
                delegate?.formSubmitHandler(self)
            }
        }
    }
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
    private var txtRepeatedPassword : UITextField = {
        let txt = UITextField()
        txt.isSecureTextEntry = true
        txt.newTextField(placeholder: "Repeated Password")
        return txt
    }()
    

    private var btnSignUp : UIButton = {
        let btn = UIButton()
        btn.newButton(title: "Sign Up", backgroundColor: UIColor(named: "button_color")!)
        return btn
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews( txtEmail, txtPassword,txtRepeatedPassword, btnSignUp)
    
        applyContraints()
        addEventsForButtons()
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func applyContraints(){
        NSLayoutConstraint.activate([
            
            //txtEmail
            txtEmail.centerXAnchor.constraint(equalTo: centerXAnchor),
            txtEmail.widthAnchor.constraint(equalToConstant: 300),
            txtEmail.heightAnchor.constraint(equalToConstant: 50),
            
            //txtPassword
            txtPassword.leadingAnchor.constraint(equalTo: txtEmail.leadingAnchor),
            txtPassword.trailingAnchor.constraint(equalTo: txtEmail.trailingAnchor),
            txtPassword.topAnchor.constraint(equalTo: txtEmail.bottomAnchor,constant: 20),
            txtPassword.heightAnchor.constraint(equalToConstant: 50),
            
            //txtRepeatedPassword
            txtRepeatedPassword.leadingAnchor.constraint(equalTo: txtEmail.leadingAnchor),
            txtRepeatedPassword.trailingAnchor.constraint(equalTo: txtEmail.trailingAnchor),
            txtRepeatedPassword.topAnchor.constraint(equalTo: txtPassword.bottomAnchor,constant: 20),
            txtRepeatedPassword.heightAnchor.constraint(equalToConstant: 50),
            
            //btnSignUp
            btnSignUp.centerXAnchor.constraint(equalTo: txtEmail.centerXAnchor),
            btnSignUp.topAnchor.constraint(equalTo: txtRepeatedPassword.bottomAnchor,constant: 40),
            btnSignUp.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    func addEventsForButtons(){
        btnSignUp.addTarget(self, action: #selector(btnSignUpTapped), for: .touchUpInside)
    }
    @objc func btnSignUpTapped(){
        isValidPassword = txtPassword.text == txtRepeatedPassword.text
        if(isValidPassword){
            email = txtEmail.text!
            password = txtPassword.text!
            isValidEmailPassword = true
        }else{
            isValidEmailPassword = false
        }
    }
    

}
