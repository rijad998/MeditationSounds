//
//  MediaViewModel.swift
//  MeditationSounds
//
//  Created by Rijad Babovic on 07/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

protocol MediaViewModelDelegate {
    func isPlaying(isPlay: Bool, index: Int)
    func displayToastMessageModel()
}


class MediaViewModel {
    
    var mediaList: [Media] = []
    var playerHandler = PlayerHandler()
    var delegate: MediaViewModelDelegate?
    
    init() {
        
        for (index, item) in FileStruc.fileName.enumerated() {
            mediaList.append(Media(fileName: item, state: .stopState, index: index))
        }
        
        playerHandler.delegate = self
    }
    
    func chooseSong(index: Int, muteButton: UIButton) {
        
        print("Model entered, song number: \(index) has been choosen")
        playerHandler.play(mediaList[index], muteButton: muteButton)
    }
    
    func muteUnMute() {
        
        playerHandler.muteUnMute()
    }
}

extension MediaViewModel: PlayerHandlerDelegate {
    
    func displayToastMessage() {
        delegate?.displayToastMessageModel()
    }
    
    func isPlayOk(isPlay: Bool, soundC: Media) {
        
        if isPlay {
            mediaList[soundC.index].state = .running
            delegate?.isPlaying(isPlay: true, index: soundC.index)
        } else {
            mediaList[soundC.index].state = .stopState
            delegate?.isPlaying(isPlay: false, index: soundC.index)
        }
    }
}
