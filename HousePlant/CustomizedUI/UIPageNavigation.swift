//
//  PageNavigation.swift
//  HousePlant
//
//  Created by Thi Hong Phuc Nguyen on 2023-03-30.
//

import UIKit

protocol PageNavigationDelegate{
    func btnPageTapped (_ sender : Any)
}
class UIPageNavigation: UIView {
    public var page : Int = 1{
        didSet{
            if(page < 1){
                page = 1
            }
            if(page > 200){
                page = 200
            }
            lblPage.text = "Page \(page)"
            if (delegate != nil){
                delegate?.btnPageTapped(self)
            }
        }
    }
    var delegate : PageNavigationDelegate?
    private var btnPrevious : UIButton = {
        let btn = UIButton()
        btn.newButton(title: "Previous", backgroundColor: UIColor(named: "button_color")!)
        return btn
    }()
    private var btnNext : UIButton = {
        let btn = UIButton()
        btn.newButton(title: "Next", backgroundColor: UIColor(named: "button_color")!)
        return btn
    }()
    private var lblPage : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        lblPage.text = "Page 1"
        addSubViews(btnPrevious, btnNext, lblPage)
        applyContraints()
        addEventForButtons()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func applyContraints(){
        NSLayoutConstraint.activate([
            //lblPage
            lblPage.centerYAnchor.constraint(equalTo: centerYAnchor),
            lblPage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            //btnPrevious
            btnPrevious.centerYAnchor.constraint(equalTo: lblPage.centerYAnchor),
            btnPrevious.trailingAnchor.constraint(equalTo: lblPage.leadingAnchor,constant: -50),
            btnPrevious.widthAnchor.constraint(equalToConstant: 100),
            
            //btnNext
            btnNext.centerYAnchor.constraint(equalTo: lblPage.centerYAnchor),
            btnNext.leadingAnchor.constraint(equalTo: lblPage.trailingAnchor, constant: 50),
            btnNext.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    func addEventForButtons(){
        btnPrevious.addTarget(self, action: #selector(btnPreviousTapped), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(btnNextTapped), for: .touchUpInside)
    }
    @objc func btnPreviousTapped (sender : UIButton!){
        page -= 1
    }
    @objc func btnNextTapped(sender : UIButton!){
        page += 1
    }

}
