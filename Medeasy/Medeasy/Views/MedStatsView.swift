//
//  MedStatsView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 09.05.2025.
//

import SwiftUI

struct MedStatsView: View {
    var body: some View {
        VStack {
            Text("This is page dedicated to your health statistics. WE HOPE YOUR HEALTH IS GREAT!")
            Image("meme")
                .resizable()
                .scaledToFit()
        }
        
    }
}

#Preview {
    MedStatsView()
}
