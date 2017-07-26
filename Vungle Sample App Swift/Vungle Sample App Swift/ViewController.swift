//
//  ViewController.swift
//  Vungle Sample App Swift
//
//  Created by Akifumi Shinagawa on 7/20/17.
//  Copyright © 2017 Vungle. All rights reserved.
//

import UIKit


class ViewController: UIViewController, VungleSDKDelegate {

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
            
            self.updateButtonState(for: self.loadButton2, enabled: false)
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
            
            self.updateButtonState(for: self.loadButton3, enabled: false)
        }
    }
    
    @IBAction func onPlayButtonTapped(_ sender: UIButton) {
        self.updateButtonState(for: self.playButton1, enabled: false)
        self.updateButtonState(for: self.playButton2, enabled: false)
        self.updateButtonState(for: self.playButton3, enabled: false)
        
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
    

// MARK: - VungleSDKDelegate Methods
    func vungleAdPlayabilityUpdate(_ isAdPlayable: Bool, placementID: String?) {
        if (isAdPlayable) {
            print("-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is available for Placement ID: \(String(describing: placementID))");
        }
        else {
            print("-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is NOT availablefor Placement ID: \(String(describing: placementID))");
        }

        if (placementID == kVungleTestPlacementID01) {
            self.updateButtonState(for: self.playButton1, enabled: isAdPlayable)
        }
        else if (placementID == kVungleTestPlacementID02) {
            self.updateButtonState(for: self.playButton2, enabled: isAdPlayable)
            self.updateButtonState(for: self.loadButton2, enabled: !isAdPlayable)
        }
        else if (placementID == kVungleTestPlacementID03) {
            self.updateButtonState(for: self.playButton3, enabled: isAdPlayable)
            self.updateButtonState(for: self.loadButton3, enabled: !isAdPlayable)
        }
    }
    
    func vungleWillShowAd(forPlacementID placementID: String?) {
        print("-->> Delegate Callback: vungleSDKwillShowAd")
        if (placementID == kVungleTestPlacementID01) {
            print("-->> Ad will show for Placment 01")
            self.updateButtonState(for: self.playButton1, enabled: false)
        }
        else if (placementID == kVungleTestPlacementID02) {
            print("-->> Ad will show for Placment 02")
            self.updateButtonState(for: self.playButton2, enabled: false)
        }
        else if (placementID == kVungleTestPlacementID03) {
            NSLog("-->> Ad will show for Placment 03")
            self.updateButtonState(for: self.playButton3, enabled: false)
        }
    }
    
    func vungleWillCloseAd(with info: VungleViewInfo, placementID: String) {
        print("-->> Delegate Callback: vungleWillCloseAdWithViewInfo")
        if (placementID == kVungleTestPlacementID01) {
            print("-->> Ad is closed for Placment 01")
        }
        else if (placementID == kVungleTestPlacementID02) {
            print("-->> Ad is closed for Placment 02")
        }
        else if (placementID == kVungleTestPlacementID03) {
            print("-->> Ad is closed for Placment 03")
        }
        
        print("Info about ad viewed: \(info)")
      
        self.updateButtons()
        self.sdk.muted = false
    }

    func vungleSDKDidInitialize() {
        print("-->> Delegate Callback: vungleSDKDidInitialize - SDK initialized SUCCESSFULLY")
        
        self.updateButtonState(for: self.loadButton2, enabled: true)
        self.updateButtonState(for: self.loadButton3, enabled: true)
    }


// MARK: - private Methods
    private func setViewDefault () {
        self.appIdLabel.text = self.kVungleAppIDPrefix + self.kVungleTestAppID
        self.placementIdLabel1.text = kVunglePlacementIDPrefix + kVungleTestPlacementID01
        self.placementIdLabel2.text = kVunglePlacementIDPrefix + kVungleTestPlacementID02
        self.placementIdLabel3.text = kVunglePlacementIDPrefix + kVungleTestPlacementID03
        
        updateButtonState(for: loadButton2, enabled: false)
        updateButtonState(for: loadButton3, enabled: false)
        updateButtonState(for: playButton1, enabled: false)
        updateButtonState(for: playButton2, enabled: false)
        updateButtonState(for: playButton3, enabled: false)
    }
    
    private func startVungle () {
        updateButtonState(for: sdkInitButton, enabled: false)
        self.placementIDsArray = [kVungleTestPlacementID01, kVungleTestPlacementID02, kVungleTestPlacementID03]
        
        self.sdk = VungleSDK.shared()
        self.sdk.delegate = self as VungleSDKDelegate
        self.sdk.setLoggingEnabled(true)
        do {
            try self.sdk.start(withAppId: kVungleTestAppID, placements: self.placementIDsArray)
        }
        catch let error as NSError {
            print("Error while starting VungleSDK :  \(error.domain)")
            
            self.updateButtonState(for: sdkInitButton, enabled: true)
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
            let options: NSDictionary = NSDictionary(dictionary: [VunglePlayAdOptionKeyOrientations : Int(orientation)])
            try self.sdk.playAd(self, options: (options as! [AnyHashable : Any]), placementID: kVungleTestPlacementID02)
        }
        catch let error as NSError {
            print("Error encountered playing ad: + \(error)");
        }
    }
    
    private func showAdForPlacement03 () {
        // Play a Vungle ad (with options). Dictionary to set custom ad options.
        let options: NSDictionary = NSDictionary(dictionary: [VunglePlayAdOptionKeyUser: "test_user_id",
                                                              VunglePlayAdOptionKeyIncentivizedAlertBodyText: "If the video isn't completed you won't get your reward! Are you sure you want to close early?",
                                                              VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText: "Close",
                                                              VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText: "Keep Watching",
                                                              VunglePlayAdOptionKeyIncentivizedAlertTitleText: "Careful!"])
        do {
            try self.sdk.playAd(self, options: (options as! [AnyHashable : Any]), placementID: kVungleTestPlacementID03)
        }
        catch let error as NSError {
            print("Error encountered playing ad: + \(error)");
        }
    }
    
    private func updateButtons () {
        self.updateButtonState(for: self.playButton1, enabled: self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID01) ? true:false)
        self.updateButtonState(for: self.playButton2, enabled: self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID02) ? true:false)
        self.updateButtonState(for: self.loadButton2, enabled: self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID02) ? false:true)
        self.updateButtonState(for: self.playButton3, enabled: self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID03) ? true:false)
        self.updateButtonState(for: self.loadButton3, enabled: self.sdk.isAdCached(forPlacementID: kVungleTestPlacementID03) ? false:true)
    }

    private func updateButtonState(for button: UIButton, enabled: Bool) {
        button.isEnabled = enabled
        button.alpha = enabled ? 1.0:0.45
    }
}

