//
//  EmptyBlockView.swift
//  Bellalive
//
//  Created by apple on 31/03/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class EmptyBlockView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var msgLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }

    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp(){
        Bundle.main.loadNibNamed("EmptyBlockView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    }
}
