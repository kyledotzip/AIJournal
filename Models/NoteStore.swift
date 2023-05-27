//
//  NoteStore.swift
//  app-kyle
//
//  Created by Kyle House on 2023/05/27.
//

import SwiftUI

@MainActor
class NoteStore: ObservableObject {
    
    @Published var notes: [Notes] = []
    
    private static func fileURL() throws -> URL {
        
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("notes.data")
        
    }
    
    func load() async throws {
        
        let task = Task<[Notes], Error> {
            
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                
                return []
                
            }
            
            let decodednotes = try JSONDecoder().decode([Notes].self, from: data)
            return decodednotes
            
        }
        
        let notes = try await task.value
        self.notes = notes
        
    }
    
    func save(notes: [Notes]) async throws {
        
        let task = Task {
            
            let data = try JSONEncoder().encode(notes)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
            
        }
        
        _ = try await task.value
        
    }
    
}
