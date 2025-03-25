//
//  ViewModel.swift
//  HeroApp
//
//  Created by Куаныш Спандияр on 18.03.2025.
//

import Foundation


final class ViewModel: ObservableObject {
    @Published private(set) var heroes: [Model] = []

    private let service: HeroService
    private let router: HeroRouter

    init(service: HeroService, router: HeroRouter) {
        self.service = service
        self.router = router
    }

    func fetchHeroes() async {
        do {
            let heroesResponse = try await service.fetchHeroes()
            await MainActor.run {
                heroes = heroesResponse.map {
                    Model(
                        id: $0.id,
                        title: $0.name,
                        description: $0.appearance.race ?? "No Race",
                        heroImage: $0.heroImageUrl,
                        fullName: $0.fullName,
                        placeOfBirth: $0.placeOfBirth ?? "Unknown",
                        occupation: $0.occupation,
                        powerStats: "Intelligence: \($0.powerstats.intelligence ?? 0), Strength: \($0.powerstats.strength ?? 0)"
                    )
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func routeToDetail(by id: Int) {
        guard let hero = heroes.first(where: { $0.id == id }) else { return }
        router.showDetails(for: hero)
    }
}
