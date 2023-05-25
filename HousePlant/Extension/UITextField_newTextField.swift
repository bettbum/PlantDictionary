//
//  UITextField_newTextField.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-07.
//

import UIKit

extension UITextField{
    func newTextField(placeholder : String){
        self.placeholder = placeholder
        self.backgroundColor = UIColor(named: "button_color")?.withAlphaComponent(0.5)
        self.layer.cornerRadius = 5
        self.tintColor = .white
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        self.leftViewMode = .always
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
