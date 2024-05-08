//
//  DiagramFilterView.swift
//  Clicker
//
//  Created by admin on 8.05.24.
//

import SwiftUI

struct DiagramFilterView: View {
    @Binding var diagramType: EditmenuType
    var body: some View {
        Picker(selection: $diagramType) {
            ForEach(EditmenuType.allCases, id:\.self) {type in
                Text(typeTyString(type))
            }
        } label: {
            Text(typeTyString(diagramType))
        }

    }
    
    func typeTyString(_ type:EditmenuType) -> String {
        switch type {
        case .clicker:
            "Clickers"
        case .clickerType:
            "Types"
        default:
            "Error"
        }
    }
}

#Preview {
    DiagramFilterView(diagramType: Binding(get: {
        .clicker
    }, set: { _ in
        
    }))
}
