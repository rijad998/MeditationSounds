//
//  PlayerHandler.swift
//  MeditationSounds
//
//  Created by Rijad Babovic on 13/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerHandlerDelegate: class {
    func isPlayOk(isPlay: Bool, soundC: Media)
    func displayToastMessage()
}

class PlayerHandler {
    
    var audioPlayers: [AudioPlayer] = []
    var currentlyPlaying = 0
    var muted: [Bool] = []
    var delegate: PlayerHandlerDelegate?
    
    init() {
        
        for _ in 0 ... limit - 1 {
            let audioP = AudioPlayer()
            audioPlayers.append(audioP)
            muted.append(false)
        }
    }
    
    func play(_ soundC: Media, muteButton: UIButton) {
        
        if soundC.state == .stopState{
            
            if currentlyPlaying < limit {
                // search for free audio player, playing song and returning positive information
                for (index, player) in audioPlayers.enumerated() {
                    
                    if player.isPlaying == false {
                        
                        player.playingSoundWith(fileName: soundC.orgName)
                        
                        if muteButton.imageView?.image == UIImage(named: "muteIcon.png") {
                            player.audioPlayer.setVolume(0, fadeDuration: 0)
                        }
                        
                        soundC.indexOfPlayer = index
                        
                        currentlyPlaying += 1
                        
                        // return information that song has been played
                        delegate?.isPlayOk(isPlay: true, soundC: soundC)
                        
                        return
                    }
                }
            } else {
                // return information that song cannot be played
                delegate?.displayToastMessage()
            }
        } else {
            // stop song
            audioPlayers[soundC.indexOfPlayer].audioPlayer.stop()
            currentlyPlaying -= 1
            print(soundC.state)
            print()
            delegate?.isPlayOk(isPlay: false, soundC: soundC)
        }
    }
    
    func muteUnMute() {
        
        for player in audioPlayers {
            if player.audioPlayer?.volume == 0 {
                player.audioPlayer?.setVolume(1, fadeDuration: 0)
            } else {
                player.audioPlayer?.setVolume(0, fadeDuration: 0)
            }
        }
    }
}
