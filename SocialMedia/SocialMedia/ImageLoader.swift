//
//  ImageLoader.swift
//  SocialMedia
//
//  Created by Куаныш Спандияр on 20.02.2025.
//

import Foundation
import UIKit


protocol ImageLoaderDelegate: AnyObject {
    // TODO: Think about protocol requirements
    // Consider: What types can conform to this protocol?
    // Consider: How does this affect memory management?
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage)
    func imageLoader(_ loader: ImageLoader, didFailWith error: Error)
}

class ImageLoader {
    // TODO: Consider reference type for delegate
    weak var delegate: ImageLoaderDelegate?
    
    // TODO: Think about closure reference type
    var completionHandler: ((UIImage?) -> Void)?
    
    func loadImage(url: URL) {
        // TODO: Implement image loading
        // Consider: How to avoid retain cycle?
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return } // Prevents strong reference
            
            // Simulate image fetching
            let image = UIImage(systemName: "photo")
            
            DispatchQueue.main.async {
                if let image = image {
                    self.delegate?.imageLoader(self, didLoad: image)
                    self.completionHandler?(image)
                } else {
                    let error = NSError(domain: "ImageLoader", code: 1, userInfo: nil)
                    self.delegate?.imageLoader(self, didFailWith: error)
                }
            }
        }
    }
}

class PostView: ImageLoaderDelegate {
    // Strong reference to `ImageLoader` is fine unless retained elsewhere
    var imageLoader: ImageLoader?

    func setupImageLoader() {
        imageLoader = ImageLoader()
        imageLoader?.delegate = self
        
        // Prevent retain cycle in closure
        imageLoader?.completionHandler = { [weak self] image in
            guard let self = self else { return }
            self.updateImage(image)
        }
    }

    func updateImage(_ image: UIImage?) {
        print("Image updated")
    }

    // MARK: - ImageLoaderDelegate
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage) {
        updateImage(image)
    }

    func imageLoader(_ loader: ImageLoader, didFailWith error: Error) {
        print("Failed to load image: \(error)")
    }
}
