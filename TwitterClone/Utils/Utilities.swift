//
//  Utilities.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 06/09/2020.
//  Copyright © 2020 Dario Gallegos. All rights reserved.
//

import UIKit

class Utilities {
    
    func inputContainerView(image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(iv)
        iv.image = image
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let separetorView = UIView()
        separetorView.backgroundColor = .white
        view.addSubview(separetorView)
        separetorView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        return tf
    }
    
    func attributedButton ( firstPart: String, secondPart: String)-> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString (string: firstPart, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes:
            [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
    
}
