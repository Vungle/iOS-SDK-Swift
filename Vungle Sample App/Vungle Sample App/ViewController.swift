//
//  ViewController.swift
//  Vungle Sample App
//
//  Created by Joel Chen on 1/11/18.
//  Copyright © 2018 Vungle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let kVungleAppIDPrefix = "AppID: "
    let kVunglePlacementIDPrefix = "PlacementID: "
    let kVungleTestAppID = "58fe200484fbd5b9670000e3"
    let kVungleTestPlacementID01 = "PLMT01-41570"
    let kVungleTestPlacementID02 = "PLMT02-05269"
    let kVungleTestPlacementID03 = "PLMT03-8358426"
    let kVungleTestPlacementID04 = "PLMT04-8738960"

    @IBOutlet weak var appIdLabel: UILabel!
    @IBOutlet weak var placementIdLabel1: UILabel!
    @IBOutlet weak var placementIdLabel2: UILabel!
    @IBOutlet weak var placementIdLabel3: UILabel!
    @IBOutlet weak var placementIdLabel4: UILabel!
    @IBOutlet weak var sdkInitButton: UIButton!
    @IBOutlet weak var loadButton2: UIButton!
    @IBOutlet weak var loadButton3: UIButton!
    @IBOutlet weak var loadButton4: UIButton!
    @IBOutlet weak var playButton1: UIButton!
    @IBOutlet weak var playButton2: UIButton!
    @IBOutlet weak var playButton3: UIButton!
    @IBOutlet weak var playButton4: UIButton!
    @IBOutlet weak var dismissButton3: UIButton!
    @IBOutlet weak var dismissButton4: UIButton!
    @IBOutlet weak var checkCurrentStatusButton: UIButton!
    @IBOutlet weak var flexFeedView: UIView!
    
    var sdk: VungleSDK?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewDefault()
    }

    private func setViewDefault() {
        appIdLabel.text = kVungleAppIDPrefix + kVungleTestAppID
        placementIdLabel1.text = kVunglePlacementIDPrefix + kVungleTestPlacementID01
        placementIdLabel2.text = kVunglePlacementIDPrefix + kVungleTestPlacementID02
        placementIdLabel3.text = kVunglePlacementIDPrefix + kVungleTestPlacementID03
        placementIdLabel4.text = kVunglePlacementIDPrefix + kVungleTestPlacementID04
        
        updateButtonState(button: self.loadButton2, enabled: false)
        updateButtonState(button: self.loadButton3, enabled: false)
        updateButtonState(button: self.loadButton4, enabled: false)
        updateButtonState(button: self.playButton1, enabled: false)
        updateButtonState(button: self.playButton2, enabled: false)
        updateButtonState(button: self.playButton3, enabled: false)
        updateButtonState(button: self.playButton4, enabled: false)
        updateButtonState(button: self.dismissButton3, enabled: false)
        updateButtonState(button: self.dismissButton4, enabled: false)
    }
    
    private func updateButtonState(button: UIButton, enabled: Bool) {
        button.isEnabled = enabled;
        button.alpha = (enabled ? 1.0 : 0.5);
    }
    
    private func updateButtons() {
        updateButtonState(button: self.playButton1, enabled: (sdk?.isAdCached(forPlacementID: kVungleTestPlacementID01))!)
        updateButtonState(button: self.loadButton2, enabled: !(sdk?.isAdCached(forPlacementID: kVungleTestPlacementID02))!)
        updateButtonState(button: self.playButton2, enabled: (sdk?.isAdCached(forPlacementID: kVungleTestPlacementID02))!)
        updateButtonState(button: self.loadButton3, enabled: !(sdk?.isAdCached(forPlacementID: kVungleTestPlacementID03))!)
        updateButtonState(button: self.playButton3, enabled: (sdk?.isAdCached(forPlacementID: kVungleTestPlacementID03))!)
        updateButtonState(button: self.loadButton4, enabled: !(sdk?.isAdCached(forPlacementID: kVungleTestPlacementID04))!)
        updateButtonState(button: self.playButton4, enabled: (sdk?.isAdCached(forPlacementID: kVungleTestPlacementID04))!)
    }
    
    private func startVungle() {
        updateButtonState(button: sdkInitButton, enabled: false)
        sdk = VungleSDK.shared()
        sdk?.delegate = self;
        sdk?.setLoggingEnabled(true)
        do {
            try sdk?.start(withAppId: kVungleTestAppID)
        } catch let error as NSError {
            print("Error while starting VungleSDK \(error.localizedDescription)")
        }
    }
    
    @IBAction func onLogStatusButtonTapped() {
        print("-->> SDK Initialized: \(sdk?.isInitialized ?? false ? "YES" : "NO")")
        print("-->> \(kVungleTestPlacementID01) - an ad loaded: \(sdk?.isAdCached(forPlacementID: kVungleTestPlacementID01) ?? false ? "YES" : "NO")")
        print("-->> \(kVungleTestPlacementID02) - an ad loaded: \(sdk?.isAdCached(forPlacementID: kVungleTestPlacementID02) ?? false ? "YES" : "NO")")
        print("-->> \(kVungleTestPlacementID03) - an ad loaded: \(sdk?.isAdCached(forPlacementID: kVungleTestPlacementID03) ?? false ? "YES" : "NO")")
        print("-->> \(kVungleTestPlacementID04) - an ad loaded: \(sdk?.isAdCached(forPlacementID: kVungleTestPlacementID04) ?? false ? "YES" : "NO")")
    }
    
    @IBAction func onInitButtonTapped() {
        startVungle();
    }
    
    @IBAction func onLoadButtonTapped(sender: UIButton) {
        if sender == loadButton2 {
            print("-->> Load an ad for \(kVungleTestPlacementID02)")
            do {
                try sdk?.loadPlacement(withID: kVungleTestPlacementID02)
                updateButtonState(button: loadButton2, enabled: false)
            } catch let error as NSError {
                print("Unable to load placement with reference ID :\(kVungleTestPlacementID02), Error \(error.localizedDescription)")
                updateButtonState(button: loadButton2, enabled: true)
            }
        } else if sender == loadButton3 {
            print("-->> Load an ad for \(kVungleTestPlacementID03)")
            do {
                try sdk?.loadPlacement(withID: kVungleTestPlacementID03)
                updateButtonState(button: loadButton3, enabled: false)
            } catch let error as NSError {
                print("Unable to load placement with reference ID :\(kVungleTestPlacementID03), Error \(error.localizedDescription)")
                updateButtonState(button: loadButton3, enabled: true)
            }
        } else if sender == loadButton4 {
            print("-->> Load an ad for \(kVungleTestPlacementID04)")
            do {
                try sdk?.loadPlacement(withID: kVungleTestPlacementID04)
                updateButtonState(button: loadButton4, enabled: false)
            } catch let error as NSError {
                print("Unable to load placement with reference ID :\(kVungleTestPlacementID04), Error \(error.localizedDescription)")
                updateButtonState(button: loadButton4, enabled: true)
            }
        }
    }
    
    @IBAction func onPlayButtonTapped(sender: UIButton) {
        if sender == playButton1 {
            print("-->> Play an ad for \(kVungleTestPlacementID01)")
            updateButtonState(button: playButton1, enabled: false)
            showAdForPlacement01()
        } else if sender == playButton2 {
            print("-->> Play an ad for \(kVungleTestPlacementID02)")
            updateButtonState(button: playButton2, enabled: false)
            showAdForPlacement02()
        } else if sender == playButton3 {
            print("-->> Play an ad for \(kVungleTestPlacementID03)")
            updateButtonState(button: playButton3, enabled: false)
            showAdForPlacement03()
        } else if sender == playButton4 {
            print("-->> Play an ad for \(kVungleTestPlacementID04)")
            updateButtonState(button: playButton4, enabled: false)
            showAdForPlacement04()
        }
    }
    
    @IBAction func onDismissButtonTapped(sender: UIButton) {
        if sender == dismissButton3 {
            sdk?.finishedDisplayingAd()
        } else if sender == dismissButton4 {
            sdk?.finishedDisplayingAd()
        }
    }
    
    private func showAdForPlacement01() {
        do {
            try sdk?.playAd(self, options: [VunglePlayAdOptionKeyUser: "UserID"], placementID: kVungleTestPlacementID01)
        } catch let error as NSError {
            print("Error encountered playing ad: \(error.localizedDescription)")
        }
    }
    
    private func showAdForPlacement02() {
        do {
            try sdk?.playAd(self, options: [VunglePlayAdOptionKeyUser: "UserID",
                                            VunglePlayAdOptionKeyIncentivizedAlertBodyText: "If the video isn't completed you won't get your reward! Are you sure you want to close early?",
                                            VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText: "Close",
                                            VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText: "Keep Watching",
                                            VunglePlayAdOptionKeyIncentivizedAlertTitleText: "Careful!"], placementID: kVungleTestPlacementID02)
        } catch let error as NSError {
            print("Error encountered playing ad: \(error.localizedDescription)")
        }
    }
    
    private func showAdForPlacement03() {
        do {
            try sdk?.playAd(self, options: [VunglePlayAdOptionKeyUser: "UserID",
                                            VunglePlayAdOptionKeyFlexViewAutoDismissSeconds: 15], placementID: kVungleTestPlacementID03)
        } catch let error as NSError {
            print("Error encountered playing ad: \(error.localizedDescription)")
        }
    }
    
    private func showAdForPlacement04() {
        do {
            try sdk?.addAdView(to: flexFeedView, withOptions: [VunglePlayAdOptionKeyUser: "UserID",
                                                               VunglePlayAdOptionKeyOrdinal: 123], placementID: kVungleTestPlacementID04)
        } catch let error as NSError {
            print("Error encountered playing ad: \(error.localizedDescription)")
        }
    }
}

extension ViewController: VungleSDKDelegate {
    func vungleSDKDidInitialize() {
        print("-->> Delegate Callback: vungleSDKDidInitialize - SDK initialized SUCCESSFULLY");
        updateButtons()
    }
    
    func vungleSDKFailedToInitializeWithError(_ error: Error) {
        print("-->> Delegate Callback: vungleSDKFailedToInitializeWithError - SDK initialization failure: \(error.localizedDescription)")
    }
    
    func vungleAdPlayabilityUpdate(_ isAdPlayable: Bool, placementID: String?, error: Error?) {
        if isAdPlayable {
            print("-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is available for Placement ID: \(placementID ?? "")")
        } else {
            print("-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is NOT available for Placement ID: \(placementID ?? "")")
        }
        
        if error != nil {
            print("-->> Delegate Callback: vungleAdPlayabilityUpdate Error: \(error!.localizedDescription)")
        }
        
        if placementID == kVungleTestPlacementID01 {
            updateButtonState(button: playButton1, enabled: isAdPlayable)
        } else if placementID == kVungleTestPlacementID02 {
            updateButtonState(button: loadButton2, enabled: !isAdPlayable)
            updateButtonState(button: playButton2, enabled: isAdPlayable)
        } else if placementID == kVungleTestPlacementID03 {
            updateButtonState(button: loadButton3, enabled: !isAdPlayable)
            updateButtonState(button: playButton3, enabled: isAdPlayable)
        } else if placementID == kVungleTestPlacementID04 {
            updateButtonState(button: loadButton4, enabled: !isAdPlayable)
            updateButtonState(button: playButton4, enabled: isAdPlayable)
        }
    }
    
    func vungleWillShowAd(forPlacementID placementID: String?) {
        print("-->> Delegate Callback: vungleWillShowAdForPlacementID")
        
        if placementID == kVungleTestPlacementID01 {
            print("-->> Ad will show for \(kVungleTestPlacementID01)")
            updateButtonState(button: playButton1, enabled: false)
        } else if placementID == kVungleTestPlacementID02 {
            print("-->> Ad will show for \(kVungleTestPlacementID02)")
            updateButtonState(button: playButton2, enabled: false)
        } else if placementID == kVungleTestPlacementID03 {
            print("-->> Ad will show for \(kVungleTestPlacementID03)")
            updateButtonState(button: playButton3, enabled: false)
            updateButtonState(button: dismissButton3, enabled: true)
        } else if placementID == kVungleTestPlacementID04 {
            print("-->> Ad will show for \(kVungleTestPlacementID04)")
            updateButtonState(button: playButton4, enabled: false)
            updateButtonState(button: dismissButton4, enabled: true)
        }
    }
    
    func vungleWillCloseAd(with info: VungleViewInfo, placementID: String) {
        print("-->> Delegate Callback: vungleWillCloseAdWithViewInfo")
    }
    
    func vungleDidCloseAd(with info: VungleViewInfo, placementID: String) {
        print("-->> Delegate Callback: vungleDidCloseAdWithViewInfo")
        
        if placementID == kVungleTestPlacementID01 {
            print("-->> Ad is closed for \(kVungleTestPlacementID01)")
        } else if placementID == kVungleTestPlacementID02 {
            print("-->> Ad is closed for \(kVungleTestPlacementID02)")
        } else if placementID == kVungleTestPlacementID03 {
            print("-->> Ad is closed for \(kVungleTestPlacementID03)")
            updateButtonState(button: self.dismissButton3, enabled: false)
        } else if placementID == kVungleTestPlacementID04 {
            print("-->> Ad is closed for \(kVungleTestPlacementID04)")
            updateButtonState(button: self.dismissButton4, enabled: false)
        }
        
        print("Info about ad viewed: \(info)")
        updateButtons()
    }
}
