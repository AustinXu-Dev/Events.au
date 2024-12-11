//
//  PhotoPicker.swift
//  Events.au
//
//  Created by Austin Xu on 2024/8/18.
//

import SwiftUI
import TOCropViewController

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var avatarImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No need to update anything here
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate {
        let photoPicker: PhotoPicker
        var picker: UIImagePickerController?
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        // Called when the user selects an image
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            self.picker = picker
            if let image = info[.originalImage] as? UIImage {
                let cropViewController = TOCropViewController(image: image)
                cropViewController.delegate = self
                cropViewController.aspectRatioPreset = .presetCustom
                cropViewController.customAspectRatio = CGSize(width: 360, height: 160)
                cropViewController.aspectRatioLockEnabled = true
                picker.present(cropViewController, animated: true)
            }
        }
        
        // Called when the user finishes cropping the image
        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
            photoPicker.avatarImage = image
            cropViewController.dismiss(animated: true)
            picker?.dismiss(animated: true)
        }
        
        // Called if the user cancels the cropping process
        func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
            cropViewController.dismiss(animated: true)
            picker?.dismiss(animated: true)
        }
        
        // Called if the user cancels image selection
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
