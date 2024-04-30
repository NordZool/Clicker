//
//  ClickersView.swift
//  Clicker
//
//  Created by admin on 24.04.24.
//

import SwiftUI

struct ClickersView: View {
    
    var body: some View {
            VStack {
                VStack {
                    ClickersStepper()
                        .padding(.bottom,-3)
                    Divider()
                }
                .padding(.bottom,-8)
                
                ScrollView {
                    ActiveClickersTableView()
                    
                    Rectangle()
                        .frame(height: 3)
                    InactiveClickersTableView()
                    
                }
            
        }
        
        
        
    }
}

#Preview {
    ClickersView()
        .environmentObject(Settings())
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
