//
//  NotesController.swift
//  Notare
//
//  Created by Bree Jeune on 3/5/20.
//  Copyright © 2020 Young. All rights reserved.
//

import Foundation

class NoteController {
    
    
    var notes: [Note] = []
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        

        return documents.appendingPathComponent("notes.plist")
    
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    // CRUD
    @discardableResult func createNote(named name: String, ofCategory category:  Category = .unassigned) -> Note {
   
    let note = Note(name: name, category: .unassigned)
       notes.append(note)
       saveToPersistentStore()
       return note
   }
    
    func listNotes() -> String {
        var output = ""
        for note in notes {
            output += "\(note.name)"
        }
        return output
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(notes)
            try data.write(to: url)
        } catch {
            print("Error Saving Note")
        }
    }
    
    func deleteFromPersistentStore(noteItem: Note) {
            guard let index = notes.firstIndex(of: noteItem) else { return }
            notes.remove(at: index)
            saveToPersistentStore()
            
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            notes = try decoder.decode([Note].self, from: data)
        } catch {
           print("Error Loading Note")
        }
    }
    
}




