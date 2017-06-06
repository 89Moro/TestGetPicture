//
//  ViewController.swift
//  TestGetPicture
//
//  Created by Ospite on 06/06/17.
//  Copyright © 2017 Ospite. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnRullino: UIButton!
    @IBOutlet weak var ivImage: UIImageView!

    var newMedia:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnCamera_TouchUp(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = false
        self.present(imagePicker,animated:true,completion: nil)
        newMedia = true
    
    
    }
    @IBAction func btnRullino_TouchUp(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum)
        {
            
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker,animated:true,completion: nil)
            newMedia = false
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        if mediaType.isEqual(to: kUTTypeImage as String)
        {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            ivImage.image = image
            
            if(newMedia == true)
            {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(ViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            }
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error:NSErrorPointer, contextInfo:UnsafeRawPointer)
    {
        if error != nil
        {
            let alert = UIAlertController(title:"Errore in salvataggio",message:"Errore in salvataggio immagine", preferredStyle:UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title:"OK", style: .cancel,handler:nil)
            alert.addAction(cancelAction)
            self.present(alert,animated: true,completion: nil)
        }
    }

}

