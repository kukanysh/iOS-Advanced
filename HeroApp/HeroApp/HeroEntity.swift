//
//  HeroEntity.swift
//  HeroApp
//
//  Created by Куаныш Спандияр on 18.03.2025.
//

import Foundation

struct HeroEntity: Decodable {
    let id: Int
    let name: String
    let appearance: Appearance
    let images: HeroImage
    let biography: Biography
    let powerstats: PowerStats
    var fullName: String {
        biography.fullName ?? "Unknown"
    }
    var placeOfBirth: String {
        biography.placeOfBirth ?? "Unknown"
    }
    var heroImageUrl: URL? {
        URL(string: images.md)
    }
    
    let work: Work
    
    var occupation: String {
        work.occupation ?? "Unknown"
    }
    
    struct Appearance: Decodable {
        let race: String?
    }
    
    struct Biography: Decodable {
        let fullName: String?
        let placeOfBirth: String?
    }
    
    struct PowerStats: Decodable {
        let intelligence: Int
        let strength: Int
        let speed: Int
        let durability: Int
        let power: Int
        let combat: Int
    }
    
    struct Work: Decodable {
            let occupation: String?
        }
    
    struct HeroImage: Decodable {
        let sm: String
        let md: String
    }
}

