//
//  PhotoPicker.swift
//  Events.au
//
//  Created by Austin Xu on 2024/8/18.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var avatarImage: UIImage?
    
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // update ui view
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker){
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage{
                guard let data = image.jpegData(compressionQuality: 0.1), let compressedImage = UIImage(data: data) else{
                    return
                }
                photoPicker.avatarImage = compressedImage
            } else{
                // show error
            }
            picker.dismiss(animated: true)
        }
    }
    
}
