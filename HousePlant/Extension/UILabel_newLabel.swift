//
//  UILabel_newLabel.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-04-07.
//

import UIKit

extension UILabel{
    func newHeaderLabel(text : String){
        self.text = text
        self.font = .systemFont(ofSize: 18, weight: .bold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func newContentLabel(){
        self.font = .systemFont(ofSize: 18, weight: .light)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 2

    }
}
