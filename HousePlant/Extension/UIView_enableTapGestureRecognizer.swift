//
//  UIView_enableTapGestureRecognizer.swift
//  MapKit
//
//  Created by Thi Hong Phuc Nguyen on 2023-02-13.
//

import UIKit

extension UIView{
    func enableTapGestureRecognizer(target : Any?, action : Selector?){
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }
}
