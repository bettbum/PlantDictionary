//
//  SignUpController.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-03.
//

import UIKit
import Firebase
import FirebaseAuth
class SignUpController: UIViewController, UISignUpFormDelegate{
    
    var logo = Logo()
    var signUpForm = UISignUpForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedNavigationBarItem()
        view.addSubViews(logo, signUpForm )
        applyConstraints()
        signUpForm.delegate = self
        
    }
    func customizedNavigationBarItem(){
        navigationController?.navigationBar.tintColor = UIColor(named: "button_color")
    }
    func applyConstraints(){
        logo.translatesAutoresizingMaskIntoConstraints = false
        signUpForm.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //logo
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            logo.heightAnchor.constraint(equalToConstant: 120),
            
            //login form
            signUpForm.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 30),
            signUpForm.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            signUpForm.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            signUpForm.heightAnchor.constraint(equalToConstant: 700),
           
            
        ])
        
        //applying ui
        view.backgroundColor = UIColor(named: "background_color")
    }
    func formSubmitHandler(_ sender: Any) {
        let email = signUpForm.email
        let password = signUpForm.password
        if (signUpForm.isValidEmailPassword){
            Auth.auth().createUser(withEmail: email , password: password){
                result, error in
                if(error != nil){
                    print("*** SIGNUP - ERROR ****\n\(error!.localizedDescription)")
                    Toast.show(view: self, title: "Error", message: error!.localizedDescription)
                    return
                }
                print("Signup sucessfully")
                Toast.ok(view: self, title: "Signed up succesfully", message: "Your account has been succesfully creared. Please log in to continue!"){result in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }else{
            if(!signUpForm.isValidPassword){
                Toast.show(view: self, title: "Error", message: "Password is not match")
            }
        }
    }
    

    

}
