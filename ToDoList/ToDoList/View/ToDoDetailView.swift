//
//  ToDoDetailView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 07.08.2025.
//

import SwiftUI

struct ToDoDetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Заняться спортом")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("25/08/25")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                
                Text("Fjfr ejnfe rnfnrh fnhjferfh rfehjfhere ffern ffh, fnenfj, jf jfnrej fjenrf")
                
                
                Spacer()
                
                
            }.padding(.horizontal, 20)
                .padding(.top, 20)
        }
    }
}

#Preview {
    ToDoDetailView()
        .preferredColorScheme(.dark)
}
