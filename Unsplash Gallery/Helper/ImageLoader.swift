//
//  ImageLoader.swift
//  Unsplash Gallery
//
//  Created by Meißner, Johannes, HSE DE on 13.10.23.
//

import SwiftUI

actor ImageLoader {
    private var images: [URLRequest: LoaderStatus] = [:]

    private enum LoaderStatus {
        case inProgress(Task<UIImage, Error>)
        case fetched(UIImage)
    }
    
    /// Fetches a given URL
    /// - Parameter url: The URL to be fetched
    /// - Returns: An async UIImage
    public func fetch(_ url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await fetch(request)
    }
    
    /// Fetches a given URLRequest
    /// - Parameter urlRequest: The URLRequest to be fetched
    /// - Returns: An async UIImage
    public func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
        // Check whether the image was downloaded already or is being downloaded
        if let status = images[urlRequest] {
            switch status {
            case .fetched(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            }
        }

        // Check the file system for the requested URL and return if found
        if let image = try self.imageFromFileSystem(for: urlRequest) {
            images[urlRequest] = .fetched(image)
            return image
        }

        // Lastly we request the image from network if not found anywhere else
        let task: Task<UIImage, Error> = Task {
            let (imageData, _) = try await URLSession.shared.data(for: urlRequest)
            let image = UIImage(data: imageData)!
            try self.persistImage(image, for: urlRequest)
            return image
        }

        // Assign the task to be pending
        images[urlRequest] = .inProgress(task)

        // After retrieving the value we persist it in memory
        let image = try await task.value
        images[urlRequest] = .fetched(image)
        
        return image
    }

    private func persistImage(_ image: UIImage, for urlRequest: URLRequest) throws {
        guard let url = fileName(for: urlRequest),
              let data = image.jpegData(compressionQuality: 0.8) else {
            assertionFailure("Unable to generate a local path for \(urlRequest)")
            return
        }
        
        try data.write(to: url)
    }

    private func imageFromFileSystem(for urlRequest: URLRequest) throws -> UIImage? {
        guard let url = fileName(for: urlRequest) else {
            assertionFailure("Unable to generate a local path for \(urlRequest)")
            return nil
        }
        
        let data = try Data(contentsOf: url)
        return UIImage(data: data)
    }
    
    private func fileName(for urlRequest: URLRequest) -> URL? {
        guard let fileName = urlRequest.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return applicationSupport.appendingPathComponent(fileName)
    }
}
