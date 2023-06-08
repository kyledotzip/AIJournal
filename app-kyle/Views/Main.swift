//
//  Main.swift
//  app-kyle
//
//  Created by Kyle House on 2023/05/23.
//

import SwiftUI

struct Main: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var noteState: NoteState
    
    @State private var isSidebarOpened = false
    @State private var message: String = ""
    
    var body: some View {
        return Group {
            if appState.notesPage {
                NotesView()
            }
            else {
                content
            }
        }
    }
    
    var content: some View {
        ZStack(alignment: .topLeading) {
            Color(.black)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Button() {
                    isSidebarOpened.toggle()
                } label: {
                    Image("menu-icon")
                }
                
                Spacer()
            }
            VStack() {
                Spacer()
                HStack() {
                    TextField("", text: $message)
                        .placeholder(when: message.isEmpty) {
                            Text("What's on your mind?")
                                .foregroundStyle(LinearGradient(
                                    colors: [.gray, .darkgray], startPoint: .leading, endPoint: .trailing
                                ))
                                .opacity(0.7)
                        }
                        .foregroundColor(.white)
                        .accentColor(.darkgray)
                        .background(Color.black)
                        .font(.title)
                        .padding()
                    Button() {
                        
                    } label: {
                    Image("send-icon")
                            .padding()
                            .opacity(0.3)
                    }
                }                
            }
            Sidebar(isSidebarVisible: $isSidebarOpened, notes: .constant(Notes.sampleData), title: .constant(""), text: .constant(""))
        }
    }
}

struct Main_Previews: PreviewProvider {

    static var previews: some View {
        Main()
            .environmentObject(AppState())
            .environmentObject(NoteState())
    }
}

struct Message {
    let id : String
    let content: String
    let dateCreated: Date
    let sender: MessageSender
}

enum MessageSender {
    case me
    case gpt
}

extension Message {
    static let sampleMessages = [
        Message(id: UUID().uuidString, content: "Sampel message from me", dateCreated: Date(), sender: .me),
        Message(id: UUID().uuidString, content: "Sampel message from gpt", dateCreated: Date(), sender: .gpt),
        Message(id: UUID().uuidString, content: "Sampel message from me", dateCreated: Date(), sender: .me),
        Message(id: UUID().uuidString, content: "Sampel message from gpt", dateCreated: Date(), sender: .gpt),
    ]
}
