//
//  Extexsions.swift
//  MeditationSounds
//
//  Created by Tech 387 on 23/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit


// MARK: -
extension UIViewController {
    
    var navH: CGFloat {
        get {
            if let nav = self.navigationController?.navigationBar {
                if !nav.isHidden {
                    return nav.bounds.height
                }
            }
            return 0
        }
    }
    
    var statusH: CGFloat {
        get {
            return UIApplication.shared.statusBarFrame.height
        }
    }
}


// MARK: -
extension UIImageView {
    
    // function of implementing different icons for different states
    func setIconByMediaState(state: MediaState) {
        
        switch state {
        case .running:
            self.image = UIImage(named: "pauseButton.png")
        default:
            self.image = UIImage(named: "playButton.png")
        }
    }
    
    func setBordersByMediaState(state: MediaState) {
        
        switch state {
        case .running:
            self.layer.borderColor = #colorLiteral(red: 0.01176470588, green: 0.8549019608, blue: 0.7764705882, alpha: 1)
            self.layer.borderWidth = 3
            self.layer.cornerRadius = 8
            
        default:
            self.layer.borderWidth = 0
            self.layer.cornerRadius = 0
        }
    }
    
    func setImageByName(name: String) {
        self.image = UIImage(named: name)
    }
    
    func loadImageData(_ imageName: String) {
        DispatchQueue.main.async {
            let file = imageName.components(separatedBy: ".")
            guard let path = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
                debugPrint( "\(file.joined(separator: ".")) not found")
                return
            }
            let url = URL(fileURLWithPath: path)
            let data = NSData(contentsOf: url)
            let img = UIImage(data: data! as Data)
            self.image = img
        }
    }
}
