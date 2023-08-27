//
//  CoreDataManager.swift
//  Protecto Pass
//
//  Created by Julian Schumacher on 25.08.23.
//

import Foundation
import CoreData

/// Struct used to interact with the Core Data Storage
internal struct CoreDataManager : DatabaseCache, DatabaseManager {
    
    internal static func load(with context : NSManagedObjectContext) throws -> [EncryptedDatabase] {
        let databases : [CD_Database] = try context.fetch(CD_Database.fetchRequest())
        allDatabases = databases
        let encryptedDatabases : [EncryptedDatabase] = DB_Converter.fromCD(databases)
        return encryptedDatabases
    }
    
    internal static func storeDatabase(_ db : EncryptedDatabase, context : NSManagedObjectContext) throws -> Void {
        if databaseExists(id: db.id) {
            update(id: <#T##UUID#>, with: <#T##EncryptedDatabase#>)
        } else {
            
        }
        try context.save()
    }
    
    internal static var allDatabases: [CD_Database] = []
    
    internal static func accessCache(id: UUID) -> CD_Database {
        return allDatabases.first(where: { $0.id == id})!
    }
    
    static func databaseExists(id : UUID) -> Bool {
        return allDatabases.contains(where: { $0.id == id })
    }
    
    static func update(id: UUID, with new: EncryptedDatabase) {
        let cdDatabase : CD_Database = accessCache(id: id)
    }
}