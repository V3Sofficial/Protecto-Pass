//
//  Folder.swift
//  Protecto Pass
//
//  Created by Julian Schumacher on 28.03.23.
//

import Foundation
import UIKit

internal class GeneralFolder<DA, DE, I> : ME_DataStructure<DA, DE, I> {}

/// The Folder Object that is used when the App is running
internal final class Folder : GeneralFolder<String, Date, UUID>, DecryptedDataStructure {
    
    /// An static preview folder with sample data to use in Previews and Tests
    internal static let previewFolder : Folder = Folder(
        name: "Private",
        description: "This is an preview Folder only to use in previews and tests",
        iconName: "folder",
        created: Date.now,
        lastEdited: Date.now,
        id: UUID()
    )
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description && lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(iconName)
        hasher.combine(created)
        hasher.combine(lastEdited)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(id)
    }
}

/// The Object holding an encrypted Folder
internal final class EncryptedFolder : GeneralFolder<Data, Data, Data>, EncryptedDataStructure {
    
    override internal init(
        name: Data,
        description: Data,
        iconName : Data,
        created : Data,
        lastEdited : Data,
        id: Data
    ) {
        super.init(
            name: name,
            description: description,
            iconName: iconName,
            created: created,
            lastEdited: lastEdited,
            id: id
        )
    }
    
    private enum FolderCodingKeys: CodingKey {
        case name
        case description
        case iconName
        case created
        case lastEdited
        case id
    }
    
    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: FolderCodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(iconName, forKey: .iconName)
        try container.encode(created, forKey: .created)
        try container.encode(lastEdited, forKey: .lastEdited)
        try container.encode(id, forKey: .id)
    }
    
    internal  convenience init(from decoder: Decoder) throws {
        let container : KeyedDecodingContainer = try decoder.container(keyedBy: FolderCodingKeys.self)
        self.init(
            name: try container.decode(Data.self, forKey: .name),
            description: try container.decode(Data.self, forKey: .description),
            iconName: try container.decode(Data.self, forKey: .iconName),
            created: try container.decode(Data.self, forKey: .created),
            lastEdited: try container.decode(Data.self, forKey: .lastEdited),
            id: try container.decode(Data.self, forKey: .id)
        )
    }
    
    internal convenience init(from coreData : CD_Folder) {
        self.init(
            name: coreData.name!,
            description: coreData.objectDescription!,
            iconName: coreData.iconName!,
            created: coreData.created!,
            lastEdited: coreData.lastEdited!,
            id: coreData.uuid!
        )
    }
}
