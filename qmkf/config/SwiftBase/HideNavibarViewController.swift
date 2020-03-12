//
//  HideNavibarViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/7.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class HideNavibarViewController : KeyboardHiddenController,UIScrollViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var navBackView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var backImageOffset: NSLayoutConstraint!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = (scrollView.contentOffset.y + CGFloat(1+zStatusBar_Height)) / 80
        setNaviColor(y)
    }
    
    func setNaviColor(_ scale: CGFloat) {
        var y : CGFloat
        scale <= 0 ? (y = CGFloat(0.001)) : (y = scale)
        if navBackView != nil {
            navBackView.backgroundColor = zRGBA(255, g: 255, b: 255, a: y)
            backButton.tintColor =  zRGBA(35/y, g: 35/y, b: 35/y, a: 1)
            shareButton.tintColor =  zRGBA(35/y, g: 35/y, b: 35/y, a: 1)
            titleLabel.textColor =  zRGBA(35/y, g: 35/y, b: 35/y, a: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if backImageOffset != nil {
            backImageOffset.constant = CGFloat(-zStatusBar_Height)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
}
