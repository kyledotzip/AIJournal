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
    
    @Binding var note: Notes
    
    @State private var title = ""
    @State private var text = ""
    
    
    var body: some View {
        
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                GeometryReader { _ in
                    VStack {
                        TextEditor(text: $title)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                            .scrollContentBackground(.hidden)
                            .placeholder(when: title.isEmpty) {
                                Text("Title")
                                    .foregroundStyle(LinearGradient(
                                        colors: [.gray, .darkgray], startPoint: .leading, endPoint: .trailing
                                    ))
                                    .opacity(0.7)
                                    .font(.largeTitle)
                                    .offset(x: 5)
                            }
                            .onChange(of: title) { newValue in
                                note.title = title
                            }
                            .disabled(isSidebarOpened)
                        Divider()
                            .overlay(.gray)
                            .padding(.horizontal, 10)
                        TextEditor(text: $text)
                            .frame(height: 585)
                            .font(.title2)
                            .foregroundColor(.white)
                            .scrollContentBackground(.hidden)
                            .placeholder(when: text.isEmpty) {
                                Text("Put your thoughts here...")
                                    .foregroundStyle(LinearGradient(
                                        colors: [.gray, .darkgray], startPoint: .leading, endPoint: .trailing
                                    ))
                                    .opacity(0.7)
                                    .font(.title2)
                                    .offset(x: 5,y: -290)
                            }
                            .onChange(of: text) { newValue in
                                note.text = text
                            }
                            .disabled(isSidebarOpened)
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
        }
        .onAppear {
            title = note.title
            text = note.text
        }
        .ignoresSafeArea(.keyboard)
    }
    
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(note: .constant(Notes.sampleNote))
    }
}
