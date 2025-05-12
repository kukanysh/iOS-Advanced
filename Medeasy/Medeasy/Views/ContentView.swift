//
//  ContentView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 09.05.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        TabView {
            
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image("line")
                    .renderingMode(.template)
                Text("Home")
            }
            
            MedStatsView()
                .tabItem {
                    Image("grommet")
                        .renderingMode(.template)
                    Text("Stats")
                }
            
            ProfileView()
                .tabItem {
                    Image("profile")
                        .renderingMode(.template)
                    Text("Profile")
                }
            
            SettingsView()
                .tabItem {
                    Image("settings")
                        .renderingMode(.template)
                    Text("Settings")
                }
            
        }.tint(.black)
            
    }
}

#Preview {
    ContentView()
}
