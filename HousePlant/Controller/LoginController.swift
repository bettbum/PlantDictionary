//
//  LoginController.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-03.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginController: UIViewController, UILoginFormDelegate {
    
    var logo = Logo()
    var loginForm = UILoginForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViews(logo, loginForm )
        applyConstraints()
        loginForm.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let previousController = self.presentingViewController as? ViewController{
            DispatchQueue.main.async {
                previousController.utilitiesBar.isUserLogged = Auth.auth().currentUser != nil
            }
        }
    }
    
    func applyConstraints(){
        logo.translatesAutoresizingMaskIntoConstraints = false
        loginForm.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //logo
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            logo.heightAnchor.constraint(equalToConstant: 120),
            
            //login form
            loginForm.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 30),
            loginForm.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginForm.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginForm.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
        //applying ui
        view.backgroundColor = UIColor(named: "background_color")
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "ToSignUpController"){
            return true
        }
        return false
    }
    func btnSignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "ToSignUpController", sender: nil)
    }
    func btnSignInTapped(_ sender: Any) {
        let email = loginForm.email
        let password = loginForm.password
        Auth.auth().signIn(withEmail: email, password: password){
            result, error in
            if(error != nil){
                print("*** SIGNIN - ERROR ****\n\(error!.localizedDescription)")
                Toast.show(view: self, title: "Error", message: error!.localizedDescription)
                return
            }
            print("Sign in sucessfully")
            Toast.ok(view: self, title: "Signed in succesfully", message: ""){result in
                let currentController = self.presentingViewController
                currentController?.dismiss(animated: true)
            }
        }
    }
    
    
    

}
