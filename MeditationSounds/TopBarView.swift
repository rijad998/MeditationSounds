//
//  topBar.swift
//  MeditationSounds
//
//  Created by Rijad Babovic on 07/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

protocol TopBarViewDelegate {
    func activateMenu()
}

class TopBarView: UIView {
    
    var delegate: TopBarViewDelegate?
    let titleLabel = UILabel()
    var yOff: CGFloat = 0

    var moreButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 36, y: 19, width: 30, height: 30))
    
    init(yOffset: CGFloat) {
        super.init(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 72))
        backgroundColor = UIColor(red: 29/255, green: 33/255, blue: 33/255, alpha: 1.0)
        config()
        yOff = yOffset
        addSubview(titleLabel)
        addSubview(moreButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        super.frame = CGRect(x: 0, y: yOff, width: UIScreen.main.bounds.width, height: 72)
        titleLabel.frame = CGRect(x: bounds.width / 2 - 55, y: 13, width: 110, height: 44)
        moreButton.frame = CGRect(x: UIScreen.main.bounds.width - 36, y: 19, width: 30, height: 30)
    }
    
    func config() {
        
        titleLabel.font = UIFont(name: Font.pacifico, size: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titleLabel.text = "Relaxing"
        moreButton.setImage(UIImage(named: "moreIcon.png"), for: .normal)
        moreButton.addTarget(self, action: #selector(moreButtonClick(button:)) , for: .touchUpInside)
    }
    
    @objc func moreButtonClick(button: UIButton) {
        delegate?.activateMenu()
    }
}

