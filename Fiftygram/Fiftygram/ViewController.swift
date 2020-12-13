import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!

    let context = CIContext()
    var original: UIImage!
    
    @IBAction func savePhoto() {
        guard let save = imageView.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(save, nil, nil, nil)
    }
    
    @IBAction func revertOriginal() {
        if original == nil {
            return
        }
        imageView.image = original
    }
    
    @IBAction func applyChrome() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CIPhotoEffectChrome")
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        display(filter: filter!)
    }

    @IBAction func applySepia() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        display(filter: filter!)
    }

    @IBAction func applyNoir() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CIPhotoEffectNoir")
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        display(filter: filter!)
    }

    @IBAction func applyVintage() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CIPhotoEffectProcess")
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        display(filter: filter!)
    }

    @IBAction func choosePhoto(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
//            open the image picker
            self.navigationController?.present(picker, animated: true, completion: nil)
        }
    }

    func display(filter: CIFilter) {
        let output = filter.outputImage!
        imageView.image = UIImage(cgImage: self.context.createCGImage(output, from: output.extent)!)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
//        this dismiss the image picker after a photo is selected
        self.navigationController?.dismiss(animated: true, completion: nil)
//        convert the selected photo and treat as a UIImage
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            put the image in our imageView
            imageView.image = image
//            keeping a copy of original image
            original = image
        }
    }
}
