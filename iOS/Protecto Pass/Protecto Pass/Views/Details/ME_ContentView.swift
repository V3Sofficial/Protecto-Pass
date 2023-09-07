//
//  ME_ContentView.swift
//  Protecto Pass
//
//  Created by Julian Schumacher on 22.08.23.
//

import SwiftUI

internal struct ME_ContentView : View {
    
    internal init(_ data : ME_DataStructure<String, Folder, Entry, Date, DB_Document, DB_Image>) {
        dataStructure = data
    }
    
    private let dataStructure : ME_DataStructure<String, Folder, Entry, Date, DB_Document, DB_Image>
    
    var body: some View {
        List {
            Section("Entries") {
                if !dataStructure.entries.isEmpty {
                    ForEach(dataStructure.entries) {
                        entry in
                        NavigationLink(entry.title) {
                            EntryDetails(entry: entry)
                        }
                    }
                } else {
                    Text("No Entries found")
                }
            }
            Section("Folder") {
                if !dataStructure.folders.isEmpty {
                    ForEach(dataStructure.folders) {
                        folder in
                        NavigationLink(folder.name) {
                            ME_ContentView(folder)
                        }
                    }
                } else {
                    Text("No Folders found")
                }
            }
            Section("Images") {
                if !dataStructure.images.isEmpty {
                    ForEach(dataStructure.images) {
                        image in
                    }
                } else {
                    Text("No Images found")
                }
            }
            Section("Documents") {
                if !dataStructure.documents.isEmpty {
                    ForEach(dataStructure.documents) {
                        document in
                    }
                } else {
                    Text("No Documents found")
                }
            }
        }
        .navigationTitle(dataStructure is Database ? "Home" : dataStructure.name)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbarRole(.navigationStack)
        .toolbar(.automatic, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    NavigationLink {
                        EditEntry()
                    } label: {
                        Label("Add Entry", systemImage: "doc")
                    }
                    NavigationLink {
                        EditFolder()
                    } label: {
                        Label("Add Folder", systemImage: "folder")
                    }
                    Divider()
                    NavigationLink {
                        Me_Details(me: dataStructure)
                    } label: {
                        Label("Details", systemImage: "info.circle")
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

internal struct ME_ContentView_Previews: PreviewProvider {
    
    @StateObject private static var db : Database = Database.previewDB
    
    static var previews: some View {
        ME_ContentView(db)
            .environmentObject(db)
    }
}
