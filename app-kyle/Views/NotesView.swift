//
//  NotesView.swift
//  app-kyle
//
//  Created by Kyle House on 2023/05/29.
//

import SwiftUI
import UIKit



struct NotesView: View {
    
   
    @State private var isSidebarOpened = false
    
    @EnvironmentObject var noteState: NoteState
    @Binding var notes: [Notes]
    @Binding var note: Notes
    @State private var test = ""
    

    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Button() {
                    isSidebarOpened.toggle()
                } label: {
                    Image("menu-icon")
                }
                GeometryReader { _ in
                    VStack {
                                TextEditor(text: $note.title)
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .bold()
                                    .scrollContentBackground(.hidden)
                                    .placeholder(when: note.title.isEmpty) {
                                        Text("Title")
                                            .foregroundStyle(LinearGradient(
                                                colors: [.gray, .darkgray], startPoint: .leading, endPoint: .trailing
                                            ))
                                            .opacity(0.7)
                                            .font(.largeTitle)
                                            .offset(x: 5)
                                }
                                    .disabled(isSidebarOpened)
                                Divider()
                                    .overlay(.gray)
                                    .padding(.horizontal, 10)
                                TextEditor(text: $note.text)
                                    .frame(height: 585)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .scrollContentBackground(.hidden)
                                    .placeholder(when: note.text.isEmpty) {
                                        Text("Put your thoughts here...")
                                            .foregroundStyle(LinearGradient(
                                                colors: [.gray, .darkgray], startPoint: .leading, endPoint: .trailing
                                            ))
                                            .opacity(0.7)
                                            .font(.title2)
                                            .offset(x: 5,y: -290)
                                    }
                                    .disabled(isSidebarOpened)
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
            Sidebar(isSidebarVisible: $isSidebarOpened, notes: $notes)
        }
        .ignoresSafeArea(.keyboard)
    }

}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(notes: .constant(Notes.sampleData), note: .constant(Notes.sampleNote))
            .environmentObject(NoteState())
    }
}
