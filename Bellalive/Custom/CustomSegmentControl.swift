//
//  CustomSegmentControl.swift
//  Bellalive
//
//  Created by APPLE on 23/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentControl: UIControl{
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    var spacing: CGFloat = 0
    
    @IBInspectable
    var borderWidth : CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor : UIColor = .clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var bgColor : UIColor = .clear{
        didSet{
            layer.backgroundColor = bgColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitle: String = ""{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var textColor : UIColor = .lightGray{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var fontSize : CGFloat = 15{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor : UIColor = .darkGray{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor : UIColor = .white{
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        buttons.removeAll()
        subviews.forEach{ $0.removeFromSuperview() }
        let buttonTitles = commaSeparatedButtonTitle.components(separatedBy: ",")
        for buttonTitle in buttonTitles{
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: fontSize)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            button.layer.cornerRadius = frame.height / 2
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].backgroundColor = selectorColor
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([sv.topAnchor.constraint(equalTo: self.topAnchor),
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        sv.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        sv.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        
    }
    
    override func draw(_ rect: CGRect) {
//        self.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = frame.height / 2
    }
    
    @objc func buttonTapped(button: UIButton){
        for (buttonIndex,btn) in buttons.enumerated(){
            btn.setTitleColor(textColor, for: .normal)
            UIView.animate(withDuration: 0.3) {
                btn.backgroundColor = .clear
            }
            if btn == button{
                
                selectedSegmentIndex = buttonIndex
                spacing = (frame.width / CGFloat(buttons.count)) / 4 - 20
                UIView.animate(withDuration: 0.31) {
                    btn.backgroundColor = self.selectorColor
                }
                
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
}

