//
//  ToastMessageView.swift
//  MeditationSounds
//
//  Created by Rijad Babovic on 20/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

class ToastMessageView: UILabel {
    
    var label = UILabel()
    var tostDisplayed = false
    
    init() {
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(view: UIView){
        
        self.frame = CGRect(x: 5, y: UIScreen.main.bounds.height - 160, width: UIScreen.main.bounds.width - 10, height: 50)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.alpha = 1
        self.layer.cornerRadius = 10
        self.text = "All players are busy 😞"
        self.textColor = UIColor.white
        self.font = UIFont(name: "Montserrat-Light", size: 14.0)
        self.textAlignment = .center
        self.clipsToBounds = true
        view.addSubview(self)
    }
    
    func displayToast(view: UIView) {
        if self.tostDisplayed == true {return}
        setup(view: view)
        UIView.animate(withDuration: 1, delay: 1.7, options: .curveEaseOut , animations: {
            self.tostDisplayed = true
            self.alpha = 0.0
        }, completion: {(isCompleted) in
            self.tostDisplayed = false
            self.removeFromSuperview()
        })
    }
}
