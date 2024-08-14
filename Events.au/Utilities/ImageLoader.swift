//
//  ImageLoader.swift
//  Events.au
//
//  Created by Akito Daiki on 24/07/2024.
//

import Foundation
import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var gotError = false
    
    public var url: String
    private var task: URLSessionDataTask?
    
    init(url: String) {
        self.url = url
        loadImage()
    }
    
    private func loadImage() {
        let imageCache = ImageCache.shared
        if let cachedImage = imageCache.get(forKey: url) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: url) else { return }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.image = nil // Set a placeholder image or display an error message
                }
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
                if let fetchImage = image {
                    imageCache.set(fetchImage, forKey: self.url)
                }
            }
        }
        task?.resume()
    }
}

struct RemoteImage: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        Group {
            
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else if imageLoader.image == nil && !imageLoader.url.isEmpty {
                // Handle the case where the image is not found
                Text("Image not found")
                    .foregroundColor(.red)
            } else {
                // Show ProgressView only when loading
                ProgressView()
            }
        }
    }
}
