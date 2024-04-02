//
//  ClickerTabView.swift
//  Clicker
//
//  Created by admin on 28.02.24.
//

import SwiftUI

struct ClickerTabView: View {
    @Binding var screenInView: ScreensEnum
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                screenInView = .clickers
            } label: {
                Image(systemName: "list.bullet")
            }
            .tag(ScreensEnum.clickers)
            .foregroundStyle(screenInView == .clickers ? Color("lightBlack") : .gray)
            .scaleEffect(1.5)
            
            Spacer()
            
            Button {
                screenInView = .graphic
            } label: {
                Image(systemName: "circle.filled.pattern.diagonalline.rectangle")
            }
            .tag(screenInView)
            .foregroundStyle(screenInView == .graphic ? Color("lightBlack") : .gray)
            .scaleEffect(1.5)
            
            Spacer()
        }
    }
}

//only for preview
fileprivate struct PreviewClickerTabView : View {
    @State private var screenInView = ScreensEnum.clickers
    var body: some View {
        ClickerTabView(screenInView: $screenInView)
    }
}

#Preview {
    PreviewClickerTabView()
}
