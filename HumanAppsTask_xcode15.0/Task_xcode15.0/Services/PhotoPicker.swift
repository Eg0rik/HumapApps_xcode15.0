//
//  PhotoPicker.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit
import PhotosUI

protocol PhotoPickerDelegate: UIViewController {
    func picker(_ picker: PhotoPicker, didSelect image: UIImage)
}

protocol PhotoPicker: NSObject {
    var delegate: PhotoPickerDelegate? { get set }
    
    func present()
}

extension PhotoPicker {
    func pleaseGiveAccessInSettings(for source: String, typeAccess: String = "") {
        let alertVC = UIAlertController(title: "No access to the \(source)", message: "Please provide \(typeAccess)access in settings", preferredStyle: .alert)
        
        alertVC.addAction(
            UIAlertAction(title: "Settings", style: .default) { action in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString),
                   UIApplication.shared.canOpenURL(settingsURL) {
                    UIApplication.shared.open(settingsURL)
                }
            }
        )
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        delegate?.present(alertVC, animated: true)
    }
}

final class PhotoLibraryPicker: NSObject, PhotoPicker {
    
    private let photoSource = "photo library"
    private let typeAccess = "full"
    
    weak var delegate: PhotoPickerDelegate?
    
    func present() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        processAuthStatus(status)
    }
}

//MARK: - Private methods
private extension PhotoLibraryPicker {
    func presentPhotoLibraryPicker() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        
        delegate?.present(picker, animated: true)
    }
    
    func processAuthStatus(_ status: PHAuthorizationStatus) {
        switch status {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                    DispatchQueue.main.async {
                        if status == .authorized || status == .limited {
                            self?.presentPhotoLibraryPicker()
                        }
                    }
                }
            case .authorized, .limited:
                presentPhotoLibraryPicker()
            default:
                pleaseGiveAccessInSettings(for: photoSource, typeAccess: typeAccess)
        }
    }
}

//MARK: PHPickerViewControllerDelegate
extension PhotoLibraryPicker: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let result = results.first else {
            picker.dismiss(animated: true)
            return
        }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
            if let image = object as? UIImage {
                DispatchQueue.main.async { [weak self] in
                    guard let self else {
                        picker.dismiss(animated: true)
                        return
                    }
                    
                    self.delegate?.picker(self, didSelect: image)
                    picker.dismiss(animated: true)
                }
            }
        }
    }
}

