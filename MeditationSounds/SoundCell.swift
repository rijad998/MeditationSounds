//
//  SoundCell.swift
//  MeditationSounds
//
//  Created by Rijad Babovic on 06/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import UIKit

// delegate of sound cell
protocol SoundCellDelegate:class {
    func play(_ index: Int)
}

class SoundCell: UICollectionViewCell {
    
    var mainImageView = UIImageView()
    var titleLabel = UILabel()
    var delegate: SoundCellDelegate?
    var playButton = UIButton()
    var iconForReview = UIImageView(image: UIImage(named: "playButton.png"))
    var bgOverlayImage: UIImageView?
    let overlayImage = UIImage(named: "gradientOverlay.png")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.gray
        setup()
    }
    
    fileprivate func setup() {
    // gradient overlay
    bgOverlayImage = UIImageView(image: overlayImage)
    // button for play and pause in cell
    playButton.addSubview(iconForReview)
    playButton.addTarget(self, action: #selector(playDidClick), for: .touchUpInside)
    titleLabel.font = UIFont(name: Font.roboto, size: 16)
    titleLabel.textColor = UIColor.white
    // adding subviewes to the cell
    addSubview(mainImageView)
    addSubview(bgOverlayImage!)
    addSubview(titleLabel)
    addSubview(playButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("Interface Builder is not supported!")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // geting background image and name which change as the cell is being reused, changing icon by the state
    var viewModel: Media? {
        didSet {
            guard let model = viewModel else {
                return
            }
            iconForReview.setIconByMediaState(state: model.state)
            mainImageView.setBordersByMediaState(state: model.state)
            mainImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height + 1)
            mainImageView.loadImageData(model.image)
            titleLabel.text = model.name
            layout()
        }
    }
    
    // function which calls delegate of cell function
    @objc func playDidClick() {
        if let model = viewModel {
            delegate?.play(model.index)
        }
    }
    
    // function for setting layouts of all subviews of cell
    func layout() {
        let plBtnOffset: CGFloat = self.frame.width / 2 - 37
        playButton.frame = CGRect(x: plBtnOffset, y: plBtnOffset, width: 74, height: 74)
        playButton.backgroundColor = UIColor.clear
        iconForReview.frame = CGRect(x: 15, y: 15, width: 44, height: 44)
        bgOverlayImage?.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height + 2)
        titleLabel.frame = CGRect(x: 8, y: self.frame.height - 25, width: bounds.width - 16, height: 20)
    }
}





