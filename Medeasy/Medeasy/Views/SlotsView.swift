//
//  Slots.swift
//  Medeasy
//
//  Created by Zhaina Igenbek on 11.05.2025.
//

import SwiftUI

struct SlotsView: View {
    @State private var selectedSlot: String? = "11 AM"
    
    let slotsByDay: [String: [String]] = [
        "Sep 10": ["11 AM", "1 PM", "3 PM", "4 PM", "6 PM"],
        "Sep 11": ["11 AM", "1 PM", "3 PM", "5 PM"],
        "Sep 12": ["11 AM", "1 PM", "3 PM"]
    ]

    var body: some View {
        VStack(alignment: .leading) {
            
            Image("fourLines")
                .resizable()
                .frame(width: 20, height: 20)
            //көрінбей тұр почему то
            
            HStack {
                Image("berdikhozhaev").resizable().frame(width: 40, height: 40).clipShape(RoundedRectangle(cornerRadius: 5))
                VStack(alignment: .leading) {
                    Text("Mynzhylky Berdikhozhayev").bold()
                    Text("Neurosurgeon").foregroundStyle(Color.blueish)
                }
            }
            .padding()

            ForEach(slotsByDay.keys.sorted(), id: \.self) { day in
                Text(day).bold().padding(.horizontal)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                    ForEach(slotsByDay[day]!, id: \.self) { slot in
                        Button(action: {
                            selectedSlot = slot
                        }) {
                            Text(slot)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedSlot == slot ? Color.lightBlue : Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal)
            }

            Button("SHOW CALENDAR") {
                // show calendar action
            }
            .foregroundColor(.blueish)
            .padding()

            Spacer()

            NavigationLink(destination: BookingConfirmationView(), label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blueish)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding()
            })
        }
    }
}

#Preview {
    SlotsView()
}
