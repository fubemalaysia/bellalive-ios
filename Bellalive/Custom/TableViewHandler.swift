//
//  TableViewHandler.swift
//  Bellalive
//
//  Created by apple on 10/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = #colorLiteral(red: 0.1333333333, green: 0.537254902, blue: 0.9568627451, alpha: 1)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "SFUIDisplay-Medium", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func setEmptyMessageImage(_ message: UIImage) {
        let messageImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageImage.image = message
        messageImage.contentMode = .center
        
        self.backgroundView = messageImage;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}


extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = #colorLiteral(red: 0.1333333333, green: 0.537254902, blue: 0.9568627451, alpha: 1)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "SFUIDisplay-Medium", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    func setEmptyMessageImage(_ message: UIImage) {
        let messageImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageImage.image = message
        messageImage.contentMode = .center
        
        self.backgroundView = messageImage;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
