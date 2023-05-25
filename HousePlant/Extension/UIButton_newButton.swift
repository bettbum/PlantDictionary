//
//  UIButton_newButton.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-07.
//

import UIKit

extension UIButton{
    func newButton(title : String, backgroundColor : UIColor){
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 10
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
