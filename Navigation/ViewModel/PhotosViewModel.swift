//
//  PhotosViewModel.swift
//  Navigation
//
//  Created by Вадим Виноградов on 21.05.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewModel {
    
    private var photoData = Photo.make()
    private var imagePrecessor = ImageProcessor()
    
    func getPhotoDataCount() -> Int {
        return photoData.count
    }
    
    func getPhotoDataAt(_ indexPatch: IndexPath) -> UIImage {
        return photoData[indexPatch.item]
    }
    
    func proccesImages(photo: UIImage, complition: @escaping (UIImage) -> Void) {
        let startTime = Date()
        imagePrecessor.processImagesOnThread(sourceImages: [photo], filter: .chrome, qos: .userInteractive, completion: { processedImages in
            let endTime = Date()
            let timeInterval = endTime.timeIntervalSince(startTime)
            print("Time to process images with QoS userInteractive: \(timeInterval) seconds")
            DispatchQueue.main.async {
                if let processedCGImage = processedImages.first {
                    let processedUImage = UIImage(cgImage: processedCGImage!)
                    complition(processedUImage)
                } else {
                    complition(UIImage(systemName: "questionmark")!)
                }
            }
        })
    }
}
