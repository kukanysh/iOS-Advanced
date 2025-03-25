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
    
    func showDetails(for model: Model) {
        let detailVC = UIHostingController(rootView: HeroDetailView(model: model))
        rootViewController?.pushViewController(detailVC, animated: true)
    }
    
//    private func makeDetailViewController(id: Int) -> UIViewController {
//        let mockVC = UIViewController()
//        mockVC.view.backgroundColor = .systemBackground
//        return mockVC
//    }
    
}

struct HeroDetailView: View {
    let model: Model

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Hero Image
                if let imageUrl = model.heroImage {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } placeholder: {
                        ProgressView()
                            .frame(height: 250)
                    }
                }

                // Hero Name
                Text(model.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)

                // Full Name
                Text("Full Name: \(model.fullName)")
                    .font(.title2)
                    .foregroundColor(.secondary)

                // Race
                Text("Race: \(model.description)")
                    .font(.title2)
                    .foregroundColor(.secondary)

                // Occupation
                Text("Occupation: \(model.occupation)")
                    .font(.title2)
                    .foregroundColor(.secondary)

                // Place of Birth
                Text("Place of Birth: \(model.placeOfBirth)")
                    .font(.title2)
                    .foregroundColor(.secondary)

                // Power Stats
                Text("Power Level: \(model.powerstat)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                    .padding(.top, 8)


                Spacer()
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }
}

