//
//  NoteModel.swift
//  Board
//
//  Created by 박상욱 on 8/25/24.
//

import Foundation
import RealityKit
import SwiftUI

@Observable
class NoteModel: Identifiable {
    var entity: Entity?
    var content: String = "Hello"
    var id: UUID = UUID()
    
    init (content: String) {
        self.content = content
        entity = Entity.createNote()
    }
}


struct NoteView: View {
    @Binding var content: String
    @State var isEditing: Bool = false
    var body: some View {
        VStack(alignment: .trailing) {
            Button {
                isEditing.toggle()
            } label: {
                isEditing ? Image(systemName: "checkmark") : Image(systemName: "pencil")
            }
            .controlSize(.mini)
            .frame(width: 27)
            
            if isEditing {
                TextEditor(text: $content)
                    .font(.system(size: 10))
                    .foregroundStyle(.black)
            } else {
                Text(content)
                    .font(.system(size: 10))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .foregroundStyle(.black)
                    .padding(.top, 3)
                    .padding(.leading, 5)
            }
            
        }
        .frame(width: 130, height: 140)
    }
}


#Preview(windowStyle: .automatic, traits: .fixedLayout(width: 150, height: 150)) {
    @Previewable @State var text = "hello"
    NoteView(content: $text)
}
