//
//  CacheImages.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

protocol CacheImagesProtocol {
    func saveImage(_ image: UIImage, url: URL)
    func getImage(from url: URL) -> UIImage?
}

final class CacheImages {

    func getDirectoryPath() -> URL? {
        let documentDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String)
        let url = URL(string: documentDirectoryPath) // convert path in url

          return url
      }

    func createFolderInDocumentDirectory() {
      let fileManager = FileManager.default
      let PathWithFolderName = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Images")

      if !fileManager.fileExists(atPath: PathWithFolderName)
      {
          try! fileManager.createDirectory(atPath: PathWithFolderName, withIntermediateDirectories: true, attributes: nil)
      }
    }

    init() {
        createFolderInDocumentDirectory()
    }

}

extension CacheImages: CacheImagesProtocol {
    func saveImage(_ image: UIImage, url: URL) {

        var objCBool: ObjCBool = true
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
        let folderPath = mainPath + "/Images/"

        let isExist = FileManager.default.fileExists(atPath: folderPath, isDirectory: &objCBool)
        if !isExist {
            do {
                try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }

        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let imageUrl = documentDirectory.appendingPathComponent("Images/\(url.lastPathComponent)")
        if let data = image.jpegData(compressionQuality: 1.0){
            do {
                try data.write(to: imageUrl)
            } catch {
                print("error saving", error)
            }
        }
    }

    func getImage(from url: URL) -> UIImage? {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
           let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
           let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
           if let dirPath = paths.first{
               let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("Images/\(url.absoluteString)")
               guard let image = UIImage(contentsOfFile: imageURL.path) else { return  nil }
               return image
           }
           return nil
    }
}
