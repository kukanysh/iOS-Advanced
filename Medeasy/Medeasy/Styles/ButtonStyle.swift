//
//  ButtonStyle.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 28.06.2025.
//

import Foundation
import SwiftUI

struct ServiceButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat = 25
    var width: CGFloat = UIScreen.main.bounds.width - 220
    var height: CGFloat = 100
    var padding: EdgeInsets = EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
    var textColor: Color = .lightBlue
    var backgroundColor: Color = .blueish
    var borderColor: Color = .blueish
    var lineWidth: CGFloat = 0
    
    
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .bold()
            .foregroundStyle(textColor)
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundStyle(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(borderColor, lineWidth: lineWidth)
                    )
                    
            )
            .padding(padding)
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
