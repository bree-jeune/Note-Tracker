////
////  CameraUseViewController.swift
////  Notare
////
////  Created by Bree Jeune on 3/2/20.
////  Copyright © 2020 Young. All rights reserved.
////
//
//import UIKit
//
//class CameraUseViewController: UIViewController {
//
//    var selectedImageTag = 0
//
//    @IBOutlet weak var topImageView: UIImageView!
//
//    @IBOutlet weak var middleImageView: UIImageView!
//
//    @IBOutlet weak var bottomImageView: UIImageView!
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addTapGestures()
//
//    }
//
//
//    func addTapGestures() {
//        let tapGR0 = UITapGestureRecognizer(target: self, action: #selector(tappedImage))
//        topImageView.addGestureRecognizer(tapGR0)
//        topImageView.tag = 1
//        let tapGR1 = UITapGestureRecognizer(target: self, action: #selector(tappedImage))
//        middleImageView.addGestureRecognizer(tapGR1)
//        middleImageView.tag = 2
//        let tapGR2 = UITapGestureRecognizer(target: self, action: #selector(tappedImage))
//        bottomImageView.addGestureRecognizer(tapGR2)
//        bottomImageView.tag = 3
//    }
//
//
//    extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//        func tappedImage(_ sender: UITapGestureRecognizer) {
//            // make sure device has a camera
//            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                // save tag of image we selected
//                if let view = sender.view {
//                    selectedImageTag = view.tag
//                }
//
//                // Setup and present default Camera View Controller
//                let imagePicker = UIImagePickerController()
//                imagePicker.delegate.self
//                imagePicker.sourceType = .camera
//                imagePicker.allowsEditing = false
//                self.present(imagePicker, animated: true, completion: nil)
//            }
//        }
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
//
//        // Dismiss the view controller
//        picker.dismiss(animated: true, completion: nil)
//
//        //Get the image we took
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//
//        //Set the picture to be the image of the selected UIImageView
//
//        switch selectedImageTag {
//        case 1:
//            topImageView.image = image
//        case 2:
//            middleImageView.image = image
//        case 3:
//            bottomImageView.image = image
//        default:
//            break
//        }
//    }
//
//}
//
