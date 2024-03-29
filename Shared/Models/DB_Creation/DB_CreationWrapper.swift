//
//  DB_CreationWrapper.swift
//  Protecto Pass
//
//  Created by Julian Schumacher on 31.05.23.
//

import Foundation

/// Wrapper to hold all Object in the Database Creation process.
/// Inherits Observable Object and may be used as State Object / Environment Object.
internal final class DB_CreationWrapper : ObservableObject {
    
    /// The Name of the Database
    internal final var name : String = ""
    
    /// The Database's description
    internal final var description : String = ""
    
    /// The IconName for this Database
    internal final var iconName : String = ""
    
    /// The Password the User chose to lock and unlock the Database with
    internal final var password : String = ""

    /// Whether or not to allow biometrics to unlock this Database
    internal final var allowBiometrics : Bool = false
    
    /// The Encryption Algorithm being used to encrypt the Database
    internal final var encryption : Cryptography.Encryption = .AES256
    
    /// The way the Database should be stored
    internal final var storageType : Storage.StorageType = .CoreData
    
    /// The Path on where to store the Database
    internal final var path : URL? = nil
}
