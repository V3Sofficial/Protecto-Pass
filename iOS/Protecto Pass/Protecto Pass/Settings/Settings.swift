//
//  Settings.swift
//  Protecto Pass
//
//  Created by Julian Schumacher on 07.09.23.
//

import Foundation
import SwiftUI

/// Enum with a case for every Settings value with the stored identifier
/// String
internal enum Settings : String, RawRepresentable {

    case largeScreen = "large_screen_preference"

    case compactMode = "compact_mode_preference"

    case appVersion = "app_version_preference"

    case buildVersion = "build_version_preference"

    case resetApp = "reset_app_preference"
}

/// Struct to manage Settings, load and update them
/// out of this App in the Systems Settings App.
internal struct SettingsHelper {

    /// Loads all the Data to:
    /// 1. the Settings App
    /// 2. This App (returns a Dictionary of all Settings and their values)
    internal static func load() -> [Settings : Bool] {
        update()
        return loadData()
    }

    /// Load the current Value of the Settings
    private static func loadData() -> [Settings : Bool] {
        let largeScreen : Bool
        let compactMode : Bool
        if checkReset() {
            largeScreen = false
            compactMode = false
            reset()
        } else {
            largeScreen = UserDefaults.standard.bool(forKey: Settings.largeScreen.rawValue)
            compactMode = UserDefaults.standard.bool(forKey: Settings.compactMode.rawValue)
        }
        return [
            .largeScreen : largeScreen,
            .compactMode : compactMode
        ]
    }

    /// Checks whether the "Reset App" Switch in the System Settings App
    /// has been set to true
    private static func checkReset() -> Bool {
        return UserDefaults.standard.bool(forKey: Settings.resetApp.rawValue)
    }

    /// Resets the App
    private static func reset() -> Void {
        Storage.clearAll()
    }

    /// Update the Settings Values in the Settings App, if necessary
    private static func update() -> Void {
        UserDefaults.standard.set(Bundle.main.infoDictionary!["CFBundleShortVersionString"], forKey: Settings.appVersion.rawValue)
        UserDefaults.standard.set(Bundle.main.infoDictionary!["CFBundleVersion"], forKey: Settings.buildVersion.rawValue)
    }
}

/// Key for the Large Screen Setting injected into the Environment
private struct LargeScreenSettingsKey : EnvironmentKey {
    static var defaultValue: Bool = false
}

/// Key for the Compact Mode Setting injected into the Environment
private struct CompactModeSettingsKey : EnvironmentKey {
    static var defaultValue: Bool = true
}

/// Defines both, the compact Mode and large Screen variable for the SwiftUI
/// Environment
internal extension EnvironmentValues {
    var compactMode : Bool {
        get { self[CompactModeSettingsKey.self] }
        set { self[CompactModeSettingsKey.self] = newValue }
    }

    var largeScreen : Bool {
        get { self[LargeScreenSettingsKey.self] }
        set { self[LargeScreenSettingsKey.self] = newValue }
    }
}