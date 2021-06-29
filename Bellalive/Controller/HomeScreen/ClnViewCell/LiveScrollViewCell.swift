//
//  LiveScrollViewCell.swift
//  Bellalive
//
//  Created by APPLE on 20/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class LiveScrollViewCell: UICollectionViewCell {
    var timer = Timer()
       var counter = 0
       @IBOutlet weak var ScrollClnView: UICollectionView!
       @IBOutlet weak var PageControl: UIPageControl!
       override func awakeFromNib() {
           super.awakeFromNib()
           ScrollClnView.tag = 040
           PageControl.currentPage = 0
           DispatchQueue.main.async {
               self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
           }
           // Initialization code
       }
       @objc func changeImage() {

       if counter < PageControl.numberOfPages {
            let index = IndexPath.init(item: counter, section: 0)
            self.ScrollClnView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            PageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.ScrollClnView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            PageControl.currentPage = counter
            counter = 1
        }

        }
}
