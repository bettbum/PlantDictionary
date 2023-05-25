//
//  UIView_addSubViews.swift
//  MapKit
//
//  Created by Thi Hong Phuc Nguyen on 2023-02-13.
//

import UIKit

extension UIView{
    func addSubViews( _ views : UIView...){
        for subView in views{
            self.addSubview(subView)
        }
    }
}
