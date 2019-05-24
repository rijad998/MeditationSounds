//
//  Media.swift
//  MeditationSounds
//
//  Created by Rijad Babovic on 07/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

enum MediaState {
    case running
    case stopState
}

import Foundation

class Media {
    
    var state: MediaState!
    private var fileName: String!
    var index: Int!
    var indexOfPlayer = -1
    
    init(fileName: String, state: MediaState, index: Int){
        self.fileName = fileName
        self.index = index
        self.state = state
    }
    
    var orgName: String {
        
        get {
            return fileName
        }
    }
    
    var sound: String {
        
        get {
            return fileName + ".mp3"
        }
    }
    
    var image: String {
        
        get {
            return fileName + ".jpg"
        }
    }
    
    var name: String {
        
        get {
            return fileName.replacingOccurrences(of: "-", with: " ").localizedCapitalized
        }
    }
}
