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
    
}


@main
struct app_kyleApp: App {
    @ObservedObject var appState = AppState(hasEntered: false, notesPage: false)
    @StateObject private var store = NoteStore()
    
    var body: some Scene {
        WindowGroup {
            if appState.hasEntered {
                Main(notes: $store.notes) {
                    Task {
                        do {
                            try await store.save(notes: store.notes)
                            print("Saving saving saving")
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                .task {
                    do {
                        try await store.load()
                        print("Shit got loaded fr")
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
                .environmentObject(appState)
            } else {
                Entering()
                    .environmentObject(appState)
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
