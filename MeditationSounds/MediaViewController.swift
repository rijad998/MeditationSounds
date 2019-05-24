//
//  ViewController.swift
//  MeditationSounds
//
//  Created by Rijad Babovic on 02/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {
    
    fileprivate var collectionView: UICollectionView!
    fileprivate var collectionViewLayout = UICollectionViewFlowLayout()
    fileprivate var topView: TopBarView!
    fileprivate var viewModel = MediaViewModel()
    fileprivate let muteButton = UIButton()
    let muteIcon = UIImage(named: "muteIcon.png")
    let unMuteIcon = UIImage(named: "unmuteIcon.png")
    let toast = ToastMessageView()
    var colViewCellWidth: CGFloat = 0
    var colViewWidth = UIScreen.main.bounds.width - 40
    
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setup()
    }

    
    ///
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.layoutSubviews()
        
        print ("PRINTAAAAAA")
        
        let collHeight = view.bounds.height - self.statusH - self.navH - topView.frame.height
        let frame = CGRect(x: 0, y: self.statusH + self.navH + topView.frame.height, width: view.bounds.width, height: collHeight)
        collectionView.frame = frame
        var numOfColumns = Int(colViewWidth / 130)
        if numOfColumns == 1 {numOfColumns = 2}
        print (numOfColumns)
        let sumOfInsets = (numOfColumns - 1) * 20
        print (sumOfInsets)
        colViewCellWidth = (colViewWidth - CGFloat(sumOfInsets)) / CGFloat(numOfColumns - 1)  
        print (colViewCellWidth)
        collectionView.reloadData()
    }
    
    
    ///
    fileprivate func setup() {
        topView = TopBarView(yOffset: statusH)
        topView.delegate = self
        viewModel.delegate = self
        setupCollectionView()
        view.addSubview(topView)
        setupMuteButton()
    }
    
    
    fileprivate func setupCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SoundCell.self, forCellWithReuseIdentifier: "SoundCell")
        collectionView.backgroundColor = UIColor(red: 29/255, green: 33/255, blue: 33/255, alpha: 1.0)
        view.addSubview(collectionView)
    }
    
    
    func setupMuteButton() {
        let mtBtnOffsetX: CGFloat = self.view.frame.width - 82
        let mtBtnOffsetY: CGFloat = self.view.frame.height - 88
        muteButton.frame = CGRect(x: mtBtnOffsetX, y: mtBtnOffsetY, width: 66, height: 66)
        muteButton.setImage(unMuteIcon, for: .normal)
        muteButton.layer.cornerRadius = 33
        muteButton.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.8549019608, blue: 0.7764705882, alpha: 1)
        muteButton.addTarget(self, action: #selector(onMuteClick(button:)), for: .touchUpInside)
        view.addSubview(muteButton)
    }
    
    
    @objc func onMuteClick(button: UIButton){
        if muteButton.imageView?.image == muteIcon {
            viewModel.muteUnMute()
            muteButton.setImage(unMuteIcon, for: .normal)
        } else {
            viewModel.muteUnMute()
            muteButton.setImage(muteIcon, for: .normal)
        }
    }
    
    
    
    func moreAction() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Rate us", style: .default, handler: { (_) in
            // URL for App Store.
            let linkToAppStore = "http://itunes.apple.com/us/app/apple-store/id375380948?mt=8"
            /* First create a URL, then check whether there is an installed app that can
             open it on the device. */
            if let url = URL(string: linkToAppStore), UIApplication.shared.canOpenURL(url) {
                // Attempt to open the URL.
                UIApplication.shared.open(url, options: [:], completionHandler: {(success: Bool) in
                    if success {
                        print("\(url) launced successfully")
                    } else{
                        print("\(url) cannot be opened")
                    }
                })
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Leave a feedback", style: .default, handler: { (_) in
            UIApplication.shared.open(URL(string:"mailto:info@tech387.com")! as URL, options: [:], completionHandler: {(success: Bool) in
                if success {
                    print("MAIL launced successfully")
                } else{
                    print("MAIL cannot be opened")
                }
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User clicked Cancel button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension MediaViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SoundCell", for: indexPath) as! SoundCell
        cell.viewModel = viewModel.mediaList[indexPath.row]
        cell.delegate = self
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: colViewCellWidth, height: colViewCellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 12, right: 20)
    }
}


// MARK: - SoundCellDelegate
extension MediaViewController: SoundCellDelegate {
    
    func play(_ index: Int) {
        print("Button \(index) is clicked")
        viewModel.chooseSong(index: index, muteButton: muteButton)
    }
}


// MARK: - MediaViewModelDelegate
extension MediaViewController: MediaViewModelDelegate {
    
    func displayToastMessageModel() {
        toast.displayToast(view: self.view)
    }
    
    func isPlaying(isPlay: Bool, index: Int) {
        self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
}


// MARK: - TopBarViewDelegate
extension MediaViewController: TopBarViewDelegate {
    
    func activateMenu() {
        moreAction()
    }
}


