//
//  ViewController.swift
//  Vungle Sample App Swift
//
//  Created by Akifumi Shinagawa on 7/20/17.
//  Copyright © 2017 Vungle. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let kVungleAppIDPrefix = "AppID: "
    let kVunglePlacementIDPrefix = "PlacementID: "
    let kVungleTestAppID = "58fe200484fbd5b9670000e3"
    let kVungleTestPlacementID01 = "DEFAULT87043" // auto cache placement
    let kVungleTestPlacementID02 = "PLMT02I05269"
    let kVungleTestPlacementID03 = "PLMT03R77999"

    @IBOutlet weak var appIdLabel: UILabel!
    @IBOutlet weak var placementIdLabel1: UILabel!
    @IBOutlet weak var placementIdLabel2: UILabel!
    @IBOutlet weak var placementIdLabel3: UILabel!
    @IBOutlet weak var sdkInitButton: UIButton!
    @IBOutlet weak var loadButton2: UIButton!
    @IBOutlet weak var loadButton3: UIButton!
    @IBOutlet weak var playButton1: UIButton!
    @IBOutlet weak var playButton2: UIButton!
    @IBOutlet weak var playButton3: UIButton!
    @IBOutlet weak var checkCurrentStatusButton: UIButton!
    
    var sdk:VungleSDK!
    var placementIDsArray:Array<String>!
    
    
// MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewDefault()
    }

    @IBAction func onInitButtonTapped(_ sender: Any) {
        self.startVungle()
    }
    
    @IBAction func onLoadButtonTapped(_ sender: UIButton) {
        if (sender == self.loadButton2) {
            print("-->> load an ad for placement 02")
            
            do {
                try self.sdk.loadPlacement(withID: kVungleTestPlacementID02)
            }
            catch let error as NSError {
                print("Unable to load placement with reference ID :\(kVungleTestPlacementID02), Error: \(error)")
                
                return
            }
            loadButton2.updateState(enabled: false)
        }
        else if (sender == self.loadButton3) {
            print("-->> load an ad for placement 03")
            
            do {
                try self.sdk.loadPlacement(withID: kVungleTestPlacementID03)
            }
            catch let error as NSError {
                print("Unable to load placement with reference ID :\(kVungleTestPlacementID03), Error: \(error)")
                
                return
            }
            loadButton3.updateState(enabled: false)
        }
    }
    
    @IBAction func onPlayButtonTapped(_ sender: UIButton) {
        playButton1.updateState(enabled: false)
        playButton2.updateState(enabled: false)
        playButton3.updateState(enabled: false)
        
        if (sender == self.playButton1) {
            print("-->> play an ad for placement 01")
            self.showAdForPlacement01()
        }
        else if (sender == self.playButton2) {
            print("-->> play an ad for placement 02")
            self.showAdForPlacement02()
        }
        else if (sender == self.playButton3) {
            print("-->> play an ad for placement 03")
            self.showAdForPlacement03()
        }
    }
    
    @IBAction func onCheckCurrentStatusButtonTapped(_ sender: Any) {
        print("Current Status ------------>> ");
        self.sdk.isInitialized ? print("-->> SDK Initialized: YES"):print("-->> SDK Initialized:NO")
        self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID01) ? print("-->> Placement 01 - an ad Loaded:: YES"):print("-->> Placement 01 - an ad Loaded::NO")
        self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID02) ? print("-->> Placement 02 - an ad Loaded:: YES"):print("-->> Placement 02 - an ad Loaded::NO")
        self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID03) ? print("-->> Placement 03 - an ad Loaded:: YES"):print("-->> Placement 03 - an ad Loaded::NO")
        print("-->>------------------ ");
    }

// MARK: - private Methods
    private func setViewDefault () {
        self.appIdLabel.text = self.kVungleAppIDPrefix + self.kVungleTestAppID
        self.placementIdLabel1.text = kVunglePlacementIDPrefix + kVungleTestPlacementID01
        self.placementIdLabel2.text = kVunglePlacementIDPrefix + kVungleTestPlacementID02
        self.placementIdLabel3.text = kVunglePlacementIDPrefix + kVungleTestPlacementID03
        
        for button in [loadButton2, loadButton3, playButton1, playButton2, playButton3] {
            button?.updateState(enabled: false)
        }        
    }
    
    private func startVungle () {
        sdkInitButton.updateState(enabled: false)
        self.placementIDsArray = [kVungleTestPlacementID01, kVungleTestPlacementID02, kVungleTestPlacementID03]
        
        self.sdk = VungleSDK.shared()
        self.sdk.delegate = self
        self.sdk.setLoggingEnabled(true)
        do {
            try self.sdk.start(withAppId: kVungleTestAppID, placements: self.placementIDsArray)
        }
        catch let error as NSError {
            print("Error while starting VungleSDK :  \(error.domain)")
            sdkInitButton.updateState(enabled: true)
            return;
        }
    }
    
    private func showAdForPlacement01() {
        // Play a Vungle ad (with default options)
        do {
            try self.sdk.playAd(self, options: nil, placementID: kVungleTestPlacementID01)
        }
        catch let error as NSError { 
             print("Error encountered playing ad: + \(error)");
        }
    }
    
    private func showAdForPlacement02 () {
        // Play a Vungle ad with muted
        self.sdk.muted = true
        do {
            let orientation = UIInterfaceOrientationMask.landscape.rawValue
            let options = [VunglePlayAdOptionKeyOrientations : Int(orientation)]
            try self.sdk.playAd(self, options: options, placementID: kVungleTestPlacementID02)
        }
        catch let error as NSError {
            print("Error encountered playing ad: + \(error)");
        }
    }
    
    private func showAdForPlacement03 () {
        // Play a Vungle ad (with options). Dictionary to set custom ad options.
        let options = [VunglePlayAdOptionKeyUser: "test_user_id",
                       VunglePlayAdOptionKeyIncentivizedAlertBodyText: "If the video isn't completed you won't get your reward! Are you sure you want to close early?",
                       VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText: "Close",
                       VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText: "Keep Watching",
                       VunglePlayAdOptionKeyIncentivizedAlertTitleText: "Careful!"]
        do {
            try self.sdk.playAd(self, options: options, placementID: kVungleTestPlacementID03)
        }
        catch let error as NSError {
            print("Error encountered playing ad: + \(error)");
        }
    }
}

extension UIButton {
    func updateState(enabled: Bool) {
        self.isEnabled = enabled
        self.alpha = enabled ? 1.0 : 0.45
    }
}
extension ViewController: VungleSDKDelegate {
    // MARK: - VungleSDKDelegate Methods
    func vungleAdPlayabilityUpdate(_ isAdPlayable: Bool, placementID: String?) {
        if (isAdPlayable) {
            print("-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is available for Placement ID: \(String(describing: placementID))");
        }
        else {
            print("-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is NOT availablefor Placement ID: \(String(describing: placementID))");
        }
        
        if (placementID == kVungleTestPlacementID01) {
            playButton1.updateState(enabled: isAdPlayable)
        }
        else if (placementID == kVungleTestPlacementID02) {
            playButton2.updateState(enabled: isAdPlayable)
            loadButton2.updateState(enabled: !isAdPlayable)
        }
        else if (placementID == kVungleTestPlacementID03) {
            playButton3.updateState(enabled: isAdPlayable)
            loadButton3.updateState(enabled: !isAdPlayable)
        }
    }
    
    func vungleWillShowAd(forPlacementID placementID: String?) {
        print("-->> Delegate Callback: vungleSDKwillShowAd")
        if (placementID == kVungleTestPlacementID01) {
            print("-->> Ad will show for Placement 01")
            playButton1.updateState(enabled: false)
            
        }
        else if (placementID == kVungleTestPlacementID02) {
            print("-->> Ad will show for Placement 02")
            playButton2.updateState(enabled: false)
        }
        else if (placementID == kVungleTestPlacementID03) {
            NSLog("-->> Ad will show for Placement 03")
            playButton3.updateState(enabled: false)
        }
    }
    
    func vungleWillCloseAd(with info: VungleViewInfo, placementID: String) {
        print("-->> Delegate Callback: vungleWillCloseAdWithViewInfo")
        if (placementID == kVungleTestPlacementID01) {
            print("-->> Ad is closed for Placement 01")
        }
        else if (placementID == kVungleTestPlacementID02) {
            print("-->> Ad is closed for Placement 02")
        }
        else if (placementID == kVungleTestPlacementID03) {
            print("-->> Ad is closed for Placement 03")
        }
        
        print("Info about ad viewed: \(info)")
        
        updateButtons()
        sdk.muted = false
    }
    
    private func updateButtons () {
        playButton1.updateState(enabled: self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID01))
        playButton2.updateState(enabled: self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID02))
        loadButton2.updateState(enabled: !self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID02))
        playButton3.updateState(enabled: self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID03))
        loadButton3.updateState(enabled: !self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID03))
    }
    
    func vungleSDKDidInitialize() {
        print("-->> Delegate Callback: vungleSDKDidInitialize - SDK initialized SUCCESSFULLY")
        loadButton2.updateState(enabled: true)
        loadButton3.updateState(enabled: true)
    }

}
