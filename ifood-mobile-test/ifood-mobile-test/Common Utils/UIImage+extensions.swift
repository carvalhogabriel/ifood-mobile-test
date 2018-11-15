//
//  UIImage+extensions.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/14/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import UIKit

class ImageManager {
    
    static let sharedInstance = ImageManager()
    private let memoryStore = ImageMemoryStore()
    private let networkStore = ImageNetworkStore()
    var updateNetworkStatusActivityIndicator: Bool = true
    
    func loadImage(url: URL, completion: @escaping (UIImage?, Error?) -> ()) {
        
        memoryStore.loadImage(url: url) { [weak self] cachedImage, memoryStoreError in
            
            if let strongSelf = self {
                if let _ = cachedImage {
                    completion(cachedImage, nil)
                } else {
                    strongSelf.setNetworkActivityIndicatorVisible(visible: true)
                    strongSelf.networkStore.loadImage(url: url, completion: { downloadedImage, networkStoreError in
                        
                        strongSelf.setNetworkActivityIndicatorVisible(visible: false)
                        strongSelf.memoryStore.saveImage(image: downloadedImage, url: url)
                        
                        completion(downloadedImage, networkStoreError)
                    })
                }
            }
        }
    }
    
    func clearCache() {
        memoryStore.removeAllImages()
    }
    
    private func setNetworkActivityIndicatorVisible(visible: Bool) {
        if updateNetworkStatusActivityIndicator {
            UIApplication.shared.isNetworkActivityIndicatorVisible = visible
        }
    }
}

class ImageMemoryStore: ImageStoreProtocol {
    
    fileprivate var imageCache = [String: UIImage]()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleMemoryNotification), name: .UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    func loadImage(url: URL, completion: @escaping (UIImage?, Error?) -> ()) {
        
        let cacheKey = key(url: url)
        let image = imageCache[cacheKey]
        
        completion(image, nil)
    }
    
    func saveImage(image: UIImage?, url: URL) {
        let cacheKey = key(url: url)
        imageCache[cacheKey] = image
    }
    
    func removeAllImages() {
        self.imageCache.removeAll()
    }
    
    private func key(url: URL) -> String {
        return url.absoluteString
    }
    
    @objc func handleMemoryNotification() {
        self.removeAllImages()
    }
}

class ImageNetworkStore: ImageStoreProtocol {
    
    func loadImage(url: URL, completion: @escaping (UIImage?, Error?) -> ()) {
        
        let request = URLRequest(url: url)
        
        NetworkClient.sharedInstance.sendRequest(request: request) { data, response, error in
            
            if let imageData = data, let image = UIImage(data: imageData) {
                
                if let responseURL = response?.url, responseURL == url {
                    completion(image, nil)
                }
            } else {
                completion(nil, nil)
            }
        }
    }
}

protocol ImageStoreProtocol {
    
    func loadImage(url: URL, completion: @escaping (UIImage?, Error?) -> ())
}

extension UIImageView {
    
    func setImageURL(url: URL?, placeholder: UIImage? = nil) {
        guard let imageURL = url else {
            image = placeholder
            return
        }
        
        ImageManager.sharedInstance.loadImage(url: imageURL) { [weak self] image, error in
            if let strongSelf = self {
                strongSelf.image = image
            }
        }
    }
}
