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
      
        // .background ~ 3 - 4 sec.
        // .default ~ 0,8 - 0,9 sec
        // .userInitiated ~ 0,9 - 1 sec.
        // .userInteractive ~ 0,8 - 1 sec.
        let startTime = Date()
        imagePrecessor.processImagesOnThread(sourceImages: [photo], filter: .chrome, qos: .background, completion: { processedImages in
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
