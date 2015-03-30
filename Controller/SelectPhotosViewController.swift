//
//  SelectPhotosViewController.swift
//  ZaoCanHui
//
//  Created by Brant on 3/20/15.
//  Copyright (c) 2015 tianmitech. All rights reserved.
//

import UIKit

enum SelectPhotosType {
    case CapturePhoto
    case CapturePhotoAndEdit
    case PickSinglePhotoAndEdit
    case PickPhotos
    case CaptureVideo
    case PickVideos
}

class SelectPhotosViewController: BaseTableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, QBImagePickerControllerDelegate {
    
    var selectType: SelectPhotosType?
    
    // 照相
    func takeAPhoto() {
        selectType = SelectPhotosType.CapturePhotoAndEdit
        var picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo
            picker.delegate = self
            picker.allowsEditing = true
            self.presentViewController(picker, animated: true, completion: nil)
        } else {
            var alert = UIAlertView(title: nil, message: "相机不可用", delegate: nil, cancelButtonTitle: "我知道了")
            alert.show()
        }
    }
    
    // 从相册选择
    func pickerSinglePhotoAndEdit() {
        selectType = SelectPhotosType.PickSinglePhotoAndEdit
        var picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.presentViewController(picker, animated: true) { () -> Void in
            
        }

    }
    
    func didSelectPhoto(photo: [NSObject: AnyObject]) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        var photos = info
        self.didSelectPhoto(info)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
