//
//  Logo.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-03-28.
//

import UIKit

class Logo: UIView {

    private var logo : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "HousePlantLogo")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(logo)
        applyContraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func applyContraints(){
        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: centerYAnchor),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 250),
            logo.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
