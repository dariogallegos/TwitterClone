//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 9/2/21.
//  Copyright © 2021 Dario Gallegos. All rights reserved.
//

import Foundation
import UIKit

class CaptionTextView: UITextView {
    
    //MARK: - Properties
    
    let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "What's happening?"
        label.backgroundColor = .white
        return label
    }()
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .red
        font = UIFont.systemFont(ofSize: 16)
        heightAnchor.constraint(equalToConstant: 600).isActive = true
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor, left: leftAnchor,paddingTop: 8, paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleTextInputChange() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
    
}
