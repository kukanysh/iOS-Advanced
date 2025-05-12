//
//  ViewModel.swift
//  ImageGallery
//
//  Created by Куаныш Спандияр on 03.04.2025.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    @Published var images: [Model] = []
    private let imageQueue = DispatchQueue(label: "imageQueue", attributes: .concurrent)

    func getImages() {
        var tempImages: [Model] = []
        let group = DispatchGroup()

        let urlStrings: [String] = (0...4).map { _ in
            "https://picsum.photos/id/\(Int.random(in: 0...1000))/500"
        }

        for url in urlStrings {
            group.enter()
            downloadImage(urlString: url) { model in
                if let model = model {
                    self.imageQueue.async(flags: .barrier) {
                        tempImages.append(model)
                    }
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.images += tempImages
        }
    }

    private func downloadImage(urlString: String, completion: @escaping (Model?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }

            if let safeData = data {
                guard let image = UIImage(data: safeData) else {
                    print("Cannot create image")
                    completion(nil)
                    return
                }

                let convertedImage = Image(uiImage: image)
                let model = Model(image: convertedImage)
                completion(model)
            }
        }
        .resume()
    }
}
