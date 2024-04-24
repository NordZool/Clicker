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
                        withAnimation(.easeOut) {
                            screenInView = screenEnumCase
                        }
                    } label: {
                        Image(systemName: screenEnumCase.rawValue)
                    }
                    .foregroundStyle(screenInView == screenEnumCase ? Color.primary : .secondary)
                    .scaleEffect(1.5)
                    Spacer()
                }
            }
    }
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
