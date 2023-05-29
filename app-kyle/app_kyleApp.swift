//
//  app_kyleApp.swift
//  app-kyle
//
//  Created by Kyle House on 2023/05/22.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var hasEntered: Bool
    @Published var notesPage: Bool
    
    init(hasEntered: Bool, notesPage: Bool) {
        self.hasEntered = hasEntered
        self.notesPage = notesPage
    }
    
    init() {
        self.hasEntered = false
        self.notesPage = false
    }
    
    func toggleEnter() {
        hasEntered = !hasEntered
    }
    
    func toggleNotesOn() {
        notesPage = true
    }
    
    func toggleNotesOff() {
        notesPage = false
    }
    
    func toggleNotes() {
        notesPage = !notesPage
    }
    
}

class NoteState: ObservableObject {
    @Published var title: String
    @Published var text: String
    
    init() {
        self.title = ""
        self.text = ""
    }
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
    func updateNotes(title: String, text: String) {
        self.title = title
        self.text = text
    }
}
    

@main
struct app_kyleApp: App {
    @ObservedObject var appState = AppState(hasEntered: false, notesPage: false)
    @ObservedObject var noteState = NoteState(title: "", text: "")
    @StateObject private var store = NoteStore()
    
    var body: some Scene {
        WindowGroup {
            if appState.hasEntered {
                Main()
                    .task {
                        do {
                            try await store.load()
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    }
                    .environmentObject(appState)
                    .environmentObject(noteState)
            } else {
                Entering()
                    .environmentObject(appState)
                    .environmentObject(noteState)
            }


        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
