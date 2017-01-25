//
//  RCValues.swift
//  Planet Tour
//
//  Created by Fran Abucillo on 23/1/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import Foundation
import Firebase

enum ValueKey: String {
  case bigLabelColor
  case appPrimaryColor
  case navBarBackground
  case navTintColor
  case detailTitleColor
  case detailInfoColor
  case subscribeBannerText
  case subscribeBannerButton
  case subscribeVCText
  case subscribeVCButton
  case shouldWeIncludePluto
  case experimentGroup
  case planetImageScaleFactor
}

class RCValues {
  
  static let sharedInstance = RCValues()
  var loadingDoneCallback: (() -> ())?
  var fetchComplete: Bool = false
  
  private init() {
    loadDefaultValues()
    fetchCloudValues()
    activateDebugMode()
  }
  
  func fetchCloudValues() {
    // 1
    // WARNING: Don't actually do this in production!
    let fetchDuration: TimeInterval = 0 // 43200 -> 12 hours
    FIRRemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) {
      [weak self] (status, error) in
      
      guard error == nil else {
        print ("Uh-oh. Got an error fetching remote values \(error)")
        return
      }
      
      // 2
      FIRRemoteConfig.remoteConfig().activateFetched()
      print ("Retrieved values from the cloud!")
      print ("Our app's primary color is \(FIRRemoteConfig.remoteConfig().configValue(forKey: "appPrimaryColor").stringValue)")
      
      self?.fetchComplete = true
      self?.loadingDoneCallback?()
    }
  }
  
  func activateDebugMode() {
    let debugSettings = FIRRemoteConfigSettings(developerModeEnabled: true)
    FIRRemoteConfig.remoteConfig().configSettings = debugSettings!
  }

  func loadDefaultValues() {
    let appDefaults: [String: NSObject] = [
      ValueKey.bigLabelColor.rawValue: "#FFFFFF66" as NSObject,
      ValueKey.appPrimaryColor.rawValue: "#FBB03B" as NSObject,
      ValueKey.navBarBackground.rawValue: "#535E66" as NSObject,
      ValueKey.navTintColor.rawValue: "#FBB03B" as NSObject,
      ValueKey.detailTitleColor.rawValue: "#FFFFFF" as NSObject,
      ValueKey.detailInfoColor.rawValue: "#CCCCCC" as NSObject,
      ValueKey.subscribeBannerText.rawValue: "Like Planet Tour?" as NSObject,
      ValueKey.subscribeBannerButton.rawValue: "Get our newsletter!" as NSObject,
      ValueKey.subscribeVCText.rawValue: "Want more astronomy facts? Sign up for our newsletter!" as NSObject,
      ValueKey.subscribeVCButton.rawValue: "Subscribe" as NSObject,
      ValueKey.shouldWeIncludePluto.rawValue: false as NSObject,
      ValueKey.experimentGroup.rawValue: "default" as NSObject,
      ValueKey.planetImageScaleFactor.rawValue: 0.33 as NSObject
    ]
    FIRRemoteConfig.remoteConfig().setDefaults(appDefaults)
  }
  
  func color(forKey key: ValueKey) -> UIColor {
    let colorAsHexString = FIRRemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "#FFFFFFFF"
    let convertedColor = UIColor(rgba: colorAsHexString)
    return convertedColor
  }
  
  func bool(forKey key: ValueKey) -> Bool {
    return FIRRemoteConfig.remoteConfig()[key.rawValue].boolValue
  }
  
  func string(forKey key: ValueKey) -> String {
    return FIRRemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
  }
  
  func double(forKey key: ValueKey) -> Double {
    if let numberValue = FIRRemoteConfig.remoteConfig()[key.rawValue].numberValue {
      return numberValue.doubleValue
    } else {
      return 0.0
    }
  }
}
