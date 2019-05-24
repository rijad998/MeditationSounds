//
//  AudioPlayer.swift
//  MeditationSounds
//
//  Created by Rijad Babovic on 08/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import AVFoundation
import UIKit

class AudioPlayer {
    
    var audioPlayer: AVAudioPlayer!
    
    func playingSoundWith(fileName: String) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "mp3")!)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch {
            print(error)
        }
    }
    
    var isPlaying: Bool {
        get {
            if let pl = audioPlayer {
                return pl.isPlaying
            }
            return false
        }
    }
}
