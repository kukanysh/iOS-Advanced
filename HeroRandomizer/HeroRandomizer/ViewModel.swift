//
//  ViewModel.swift
//  HeroRandomizer
//
//  Created by Куаныш Спандияр on 02.03.2025.
//

import Foundation


final class ViewModel: ObservableObject {
    @Published var selectedHero: Hero?
    
    
    
    func fetchHero() async {
        guard
            let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json")
        else {
            return
        }
        
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let(data, _) = try await URLSession.shared.data(for: urlRequest)
            let heroes = try JSONDecoder().decode([Hero].self, from: data)
            let randomHero = heroes.randomElement()
            
            await MainActor.run {
                selectedHero = randomHero
            }
        }
        catch {
            print("Error fetching hero \(error)")
            
        }
    }
}
