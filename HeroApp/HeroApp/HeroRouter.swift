//
//  HeroRouter.swift
//  HeroApp
//
//  Created by Куаныш Спандияр on 21.03.2025.
//

import SwiftUI
import UIKit

final class HeroRouter {
    var rootViewController: UINavigationController?
    
    func showDetails(for hero: Model) {
        let detailVC = makeDetailViewController(hero: hero)
        rootViewController?.pushViewController(detailVC, animated: true)
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }

    
    private func makeDetailViewController(hero: Model) -> UIViewController {
        let detailVC = UIViewController()
        detailVC.view.backgroundColor = .systemBackground

        // Hero Image
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageUrl = hero.heroImage {
            loadImage(from: imageUrl, into: imageView)
        }

        // Hero Name
        let nameLabel = UILabel()
        nameLabel.text = hero.title
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

//        // Hero Details
//        let detailsLabel = UILabel()
//        detailsLabel.text = """
//        Full Name: \(hero.fullName)
//        Birthplace: \(hero.placeOfBirth ?? "Unknown")
//        Occupation: \(hero.occupation)
//        
//        Intelligence: \(hero.powerStats.intelligence ?? 0)
//        Strength: \(hero.powerStats.strength ?? 0)
//        Speed: \(hero.powerStats.speed ?? 0)
//        Durability: \(hero.powerStats.durability ?? 0)
//        Power: \(hero.powerStats.power ?? 0)
//        Combat: \(hero.powerStats.combat ?? 0)
//        """
//        detailsLabel.font = UIFont.systemFont(ofSize: 16)
//        detailsLabel.numberOfLines = 0
//        detailsLabel.textAlignment = .center
//        detailsLabel.textColor = .darkGray
//        detailsLabel.translatesAutoresizingMaskIntoConstraints = false

        // Stack View for clean alignment
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false

        detailVC.view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: detailVC.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: detailVC.view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: detailVC.view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: detailVC.view.trailingAnchor, constant: -16),
            
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])

        return detailVC
    }


}

