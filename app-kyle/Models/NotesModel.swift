//
//  NotesModel.swift
//  app-kyle
//
//  Created by Kyle House on 2023/05/27.
//

import Foundation

struct Notes: Identifiable, Codable {
    
    let id: UUID
    var title: String
    var text: String
    
    init(id: UUID = UUID(), title: String, text: String) {
        self.id = id
        self.title = title
        self.text = text
    }
    
}

extension Notes {
    
    static var newNote: Notes {
        
        Notes(title: "Title", text: "")
        
    }
    
}

extension Notes {
    
    static let sampleData: [Notes] =
    [
        Notes(title: "My First Note",
              text: "This is my very first note ever!"),
        Notes(title: "Dear Diary", text: "I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... I had a dream... "),
        Notes(title: "This is my super super long title!", text: "Hello! :)")
    ]
    
    static let sampleNote: Notes = Notes(title: "", text: "")
}

