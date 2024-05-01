//
//  ClickersStepper.swift
//  Clicker
//
//  Created by admin on 29.04.24.
//

import SwiftUI

struct ClickersStepper: View {
    @FetchRequest(
        entity: Clicker.entity(), sortDescriptors: [],
        predicate: NSPredicate(format: "isActive == %@", NSNumber(value:true)))
    private var clickers: FetchedResults<Clicker>
    
    var body: some View {
        HStack {
            Button {
                clickers.forEach { clicker in
                    clicker.reduceOperation()
                }
            } label: {
                Image(systemName: "minus")
                .modifyStepper()
            }
            
            
            
            Button {
                clickers.forEach { clicker in
                    clicker.increaseOperation()
                }
            } label: {
                Image(systemName: "plus")
                    .modifyStepper()
            }
        }
        .padding(.horizontal,10)
    }
}

//buttons lable modifyer
fileprivate struct StepperModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight:30)
            .contentShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.black)
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.5)))
        
    }
}

fileprivate extension View {
    func modifyStepper() -> some View {
        self.modifier(StepperModifier())
    }
}

#Preview {
    ClickersStepper()
}
