//
//  ClickerTabView.swift
//  Clicker
//
//  Created by admin on 28.02.24.
//

import SwiftUI

struct ClickerTabViewBar: View {
    @Binding var screenInView: ScreensEnum
    
    var body: some View {
            HStack {
                Spacer()
                ForEach(ScreensEnum.allCases, id:\.self) {screenEnumCase in
                    Button {
                        withAnimation(.easeOut(duration: 0.2)) {
                            screenInView = screenEnumCase
                        }
                    } label: {
                        Image(systemName: screenEnumCase.rawValue)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(screenInView == screenEnumCase ? Color.primary : .secondary)
                    .scaleEffect(screenInView == screenEnumCase ? 1.8 : 1.5)
                    
                    Spacer()
                }
            }
    }
}

//rawValue = "systemImageString"
//Codable only for save 'currentScreen' value in 'Settings'
enum ScreensEnum : String, CaseIterable, Codable{
    case clickers = "minus.forwardslash.plus"
    case graphic = "chart.pie.fill"
    case settings = "gearshape.fill"
}


//only for preview
fileprivate struct PreviewClickerTabView : View {
    @State private var screenInView = ScreensEnum.clickers
    var body: some View {
        ClickerTabViewBar(screenInView: $screenInView)
    }
}

#Preview {
    PreviewClickerTabView()
}
