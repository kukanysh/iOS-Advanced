//
//  Model.swift
//  HeroRandomizer
//
//  Created by Куаныш Спандияр on 02.03.2025.
//

import Foundation

struct Hero: Decodable {
    
    
    let images: Image
    var imageUrl: URL? {
        URL(string: images.md)
    }
    let name: String
    let appearance: Appearance
    var gender: String {
        appearance.gender ?? "Unknown"
    }
    var race: String {
        appearance.race ?? "Unknown"
    }
    
    var height: String {
        appearance.height.last ?? "Unknown"
    }
    
    var weight: String {
        appearance.weight.last ?? "Unknown"
    }
    
    
    
    let biography: Biography
    
    var fullName: String {
       biography.fullName ?? "Unknown"
    }
    var placeOfBirth: String? {
        biography.placeOfBirth ?? "Unknown"
    }
    var firstAppearance: String {
        biography.firstAppearance ?? "Unknown"
    }
    var publisher: String {
        biography.publisher ?? "Unknown"
    }
    var alignment: String {
        biography.alignment ?? "Unknown"
    }
    
    let work: Work
    
    var occupation: String {
        work.occupation ?? "Unknown"
    }
    
    
   
    
    struct Image: Decodable {
        let md: String
    }
    
    struct  Appearance: Decodable {
        let gender: String?
        let race: String?
        let height: [String]
        let weight: [String]
    }
    
    struct Biography: Decodable {
        let fullName: String?
        let placeOfBirth: String?
        let firstAppearance: String?
        let publisher: String?
        let alignment: String?
        
    }
    
    struct Work: Decodable {
        let occupation: String?
    }
    
    
}
